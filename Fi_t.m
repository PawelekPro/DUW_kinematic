function Fi_t = Fi_t(w,q,t)

Fi_t = zeros(3*(size(q,1)-1),1);
n = 0;

for i = 1:length(w)
    if (w(i).typ(1:4) == 'kine')   
        if (w(i).klasa(1:4) == 'obro')
            Fi_t(n+1:n+2) = zeros(2,1);
            n = n + 2;
        elseif (w(i).klasa(1:4) == 'post')
            Fi_t(n+1:n+2) = zeros(2,1);
            n = n + 2;
        end
     elseif (w(i).typ(1:4) == 'kier')
         if (w(i).klasa(1:4) == 'post')
            Fi_t(n+1:n+2) = zeros(2,1);
            Fi_t(n+3) = -eval(w(i).funprim);
            n = n + 3;
         end
    end
end

end
