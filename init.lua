-- 캐시 및 경로 설정
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- lazy.nvim 이 설치되지 않은 경우 부트스트랩
if not vim.uv.fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

-- lazy.nvim 을 runtime path 에 추가
vim.opt.rtp:prepend(lazypath)

-- lazy.nvim 설정 및 플러그인 로드
local lazy_config = require("configs.lazy")

-- 플러그인 로드
require("lazy").setup({
	import = "plugins",
}, lazy_config)

-- 테마 및 외관 설정
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- 기타 설정
require("options")
require("autocmds")

-- 비동기로 로드
vim.schedule(function()
	require("mappings")
end)
