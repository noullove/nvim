require("nvchad.options")

local o = vim.o
o.cursorlineopt = "both" -- cursorline 설정
o.fileencodings = "utf-8,euc-kr,cp949" -- 파일 인코딩
o.breakindent = true -- 자동 줄바꿈 시 들여쓰기
o.linebreak = true -- 줄바꿈 시 단어 단위로
o.showbreak = "↪ " -- 줄바꿈 시 보여지는 문자
o.completeopt = "menu,menuone,noinsert,popup"
