#retorna a velocidade de rotação da engrenagem com relação a rotação do pinhão

#r = dp/dg
function wg = wg(r,wp)
  wg = wp*r
endfunction
