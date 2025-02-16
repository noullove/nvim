require("nvchad.mappings")

-- 변수 설정
local map = vim.keymap.set
local unmap = vim.keymap.del

-- disabled 플러그인 키 맵핑 삭제
-- nvim-tree
unmap("n", "<C-n>")
unmap("n", "<leader>e")
unmap("n", "<leader>n")

-- telescope
unmap("n", "<leader>ma")
unmap("n", "<leader>fh")
unmap("n", "<leader>fw")
unmap("n", "<leader>fb")
unmap("n", "<leader>gt")
unmap("n", "<leader>ff")
unmap("n", "<leader>pt")
unmap("n", "<leader>fo")
unmap("n", "<leader>cm")
unmap("n", "<leader>fz")
unmap("n", "<leader>th")
unmap("n", "<leader>fa")

-- 사용자 키 맵핑
-- visual block mode
map('n', '<C-v>', '<C-v>', { noremap = true, silent = true })
-- 전체선택
map('n', '<C-a>', 'ggVG', { noremap = true, silent = true })
-- 새로운 탭 생성
map('n', '<leader>t', '<cmd>tabnew<CR>', { desc = "new tab", noremap = true, silent = true })

-- 한글모드 일때도 ESC 로 영문모드로 전환
map("n", "<Esc>", function()
	vim.fn.system("im-select com.apple.keylayout.ABC")
	vim.cmd("noh")
end, { desc = "Clear" })

-- command mode
map("n", ";", ":", { desc = "CMD enter command mode" })

-- new terminals
map("n", "<leader>h", function()
  require("nvchad.term").new { pos = "sp", size = 0.5 }
end, { desc = "terminal new horizontal term" })

map("n", "<leader>v", function()
  require("nvchad.term").new { pos = "vsp", size = 0.5 }
end, { desc = "terminal new vertical term" })

-- toggleable
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", size = 0.5, id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", size = 0.5, id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", float_opts = { row = 0.2, col = 0.2, width = 0.6, height = 0.6 }, id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

-- volt menu
-- Keyboard users
map("n", "<C-t>", function()
	require("menu").open("default", { border = true })
end, {})

-- volt menu
-- mouse users + nvimtree users!
map({ "n", "v" }, "<RightMouse>", function()
	require("menu.utils").delete_old_menus()

	vim.cmd.exec('"normal! \\<RightMouse>"')

	-- clicked buf
	local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
	local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

	require("menu").open(options, { mouse = true, border = true })
end, {})

-- snacks remapping
map("n", "<leader>e", function() require('snacks').explorer() end, { desc = "File Explorer" })
map("n", "<leader>n", function() require('snacks').picker.notifications() end, { desc = "Notification History" })
map("n", "<leader>fb", function() require('snacks').picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>ff", function() require('snacks').picker.files() end, { desc = "Find Files" })
map("n", "<leader>fz", function() require('snacks').picker.zoxide() end, { desc = "Zoxide" })

-- theme picker
map("n", "<leader>th", function ()
  require('snacks').picker.select(
    require('nvchad.utils').list_themes(),
    {},
    function(item)
     require('nvchad.themes.utils').reload_theme(item)
    end
  )
end, { desc = "theme picker" })

-- pandoc
map('n', '<leader>p', [[:lua PandocConvert()<CR>]], { desc = "pandoc convert", noremap = true, silent = true })

function PandocConvert()

  if vim.bo.filetype ~= "markdown" then
    vim.notify("PandocConvert can only be used with markdown files", vim.log.levels.WARN)
    return
  end

  local filename = vim.fn.expand('%:p')
  local filedir = vim.fn.expand('%:p:h')
  local output = vim.fn.expand('%:p:r') .. '.pdf'

  -- Change the working directory to the file's directory
  vim.fn.chdir(filedir)

  -- Remove the notification if you don't want it
  vim.notify('Converting ' .. string.format("%q", filename) .. ' to ' .. string.format("%q", output))

  local command = string.format(
    'pandoc --template=$HOME/.config/pandoc/templates/document.tex --lua-filter=$HOME/.config/pandoc/filters/parse-module.lua --lua-filter=$HOME/.config/pandoc/filters/table.lua --pdf-engine=xelatex --pdf-engine-opt="-shell-escape" --pdf-engine-opt="-output-directory=$TMPDIR" --metadata=plantuml_path:"$HOME/.config/pandoc/filters/plantuml.jar" --metadata=mainfont:NanumGothic --metadata=monofont:D2Coding --metadata=toc:true --metadata=toc_depth:3 --metadata=number_sections:false --from=markdown+hard_line_breaks -o %q %q',
    output, filename
  )

  -- Use vim.fn.jobstart for non-blocking execution
  vim.fn.jobstart(command, {
    on_stdout = function(_, data)
      if data then
        print(table.concat(data, "\n"))
      end
    end,
    on_stderr = function(_, data)
      if data then
        print("Error: " .. table.concat(data, "\n"))
      end
    end,
    on_exit = function(_, code)
      if code == 0 then
        print("Conversion successful: " .. string.format("%q", output))
        vim.cmd('silent !open ' .. string.format("%q", output))
      else
        print("Conversion failed with exit code: " .. code)
      end
    end,
  })
end
