decorate_string <- function(pattern, ...) {
  
  #������� ���������� ������  
  revString = function(pattern, index = 1:nchar(pattern)){
    paste(rev(unlist(strsplit(pattern, NULL)))[index], collapse = "")
  } 
  #�����������
paste0(pattern, paste(...), revString(pattern))
}


