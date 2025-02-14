require("nvchad.options")

local o = vim.o
o.cursorline = false -- cursorline 설정
o.cursorlineopt = "both" -- cursorline 설정
o.fileencodings = "utf-8,euc-kr,cp949" -- 파일 인코딩
o.breakindent = true -- 자동 줄바꿈 시 들여쓰기
o.linebreak = true -- 줄바꿈 시 단어 단위로
o.showbreak = "↪ " -- 줄바꿈 시 보여지는 문자
o.completeopt = "menu,menuone,noinsert,noselect,popup" -- 자동완성 옵션
o.laststatus = 3 -- 상태바 표시
