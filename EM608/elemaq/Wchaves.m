function w_chaveta = Wchaves(d)
          if d  <= 0.312
              w_chaveta = 0.04;
          elseif 0.312 < d && d <=0.437
              w_chaveta = 0.093; %#ok<*SAGROW>
          elseif 0.437 < d && d <=0.562
              w_chaveta = 0.125;
          elseif 0.562 < d && d <=0.875
              w_chaveta = 0.187;
          elseif 0.875 < d && d <=1.250
              w_chaveta = 0.250;
          elseif 1.250 < d && d <=1.375
              w_chaveta = 0.312;
          elseif 1.375 < d && d <=1.750
              w_chaveta = 0.375;
          elseif 1.75 < d && d  <=2.25
              w_chaveta =0.5;
          elseif 2.25 < d && d <=2.75
              w_chaveta =0.625;
          elseif 2.75 < d && d <=3.25
              w_chaveta =0.75;
          elseif 3.25 < d && d <=3.75
              w_chaveta =0.875;
          else
              w_chaveta =1.5;
end
