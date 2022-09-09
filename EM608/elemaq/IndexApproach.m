#Função que procura o índice mais conservador p/ engrenagem
function index = IndexApproach(N,IndexV)
  index = 1;
  for i=2:length(IndexV)
    if IndexV(i) > N
      index = i-1;
      break
    endif
  endfor
endfunction
