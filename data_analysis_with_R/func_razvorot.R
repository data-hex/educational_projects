decorate_string <- function(pattern, ...) {
  
  #функция переворота строки  
  revString = function(pattern, index = 1:nchar(pattern)){
    paste(rev(unlist(strsplit(pattern, NULL)))[index], collapse = "")
  } 
  #объединение
paste0(pattern, paste(...), revString(pattern))
}


