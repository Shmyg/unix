if exists("did_load_filetypes")
 finish
endif
 augroup filetypedetect
 au! BufRead,BufNewFile *.ctl         setfiletype ctl
augroup END
