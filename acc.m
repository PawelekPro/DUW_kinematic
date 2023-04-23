function acc = acc(w,q,t)

% macierz Omega
omega = [0 -1; 1 0];
%macierz jednostkowa
I = eye(2);
n = 0;
acc = zeros(3*(size(q,1)-1),1);

for i = 1:length(w)
    if (w(i).bodyi == 0)
        if (w(i).typ(1:4) == 'kine')
            if (w(i).klasa(1:4) == 'obro')
                %rownanie 2.42
                acc(n+1:n+2) = rot(q(size(q,1),3))*w(i).sA*q(size(q,1),6)^2 - rot(q(w(i).bodyj,3))*w(i).sB*q(w(i).bodyj,6)^2;
                n = n + 2;
            elseif (w(i).klasa(1:4) == 'post')
                %rownanie 2,48 i 2.59
                acc(n+1:n+2) = [0; (rot(q(w(i).bodyj,3))*w(i).v)'*(2*omega*([q(w(i).bodyj,4); q(w(i).bodyj,5)] - [q(size(q,1),4); q(size(q,1),5)])*q(w(i).bodyj,6) + ([q(w(i).bodyj,1); q(w(i).bodyj,2)] - [q(size(q,1),1); q(size(q,1),2)])*q(w(i).bodyj,6)^2 - rot(q(size(q,1),3))*w(i).sA*(q(w(i).bodyj,6) - q(size(q,1),6))^2)];
                n = n + 2;
            end
        elseif (w(i).typ(1:4) == 'kier')
            if (w(i).klasa(1:4) == 'post')
                %rownanie 2.59
                acc(n+1:n+2) = [0; (rot(q(w(i).bodyj,3))*w(i).v)'*(2*omega*([q(w(i).bodyj,4); q(w(i).bodyj,5)] - [q(size(q,1),4); q(size(q,1),5)])*q(w(i).bodyj,6) + ([q(w(i).bodyj,1); q(w(i).bodyj,2)] - [q(size(q,1),1); q(size(q,1),2)])*q(w(i).bodyj,6)^2 - rot(q(size(q,1),3))*w(i).sA*(q(w(i).bodyj,6) - q(size(q,1),6))^2)];
                %rownanie 2.59 z uwzglednieniem pochodnej tt
                acc(n+3) = (rot(q(w(i).bodyj,3))*w(i).u)'*(2*omega*([q(w(i).bodyj,4); q(w(i).bodyj,5)] - [q(size(q,1),4); q(size(q,1),4)])*q(w(i).bodyj,6) + ([q(w(i).bodyj,1); q(w(i).bodyj,2)] - [q(size(q,1),1); q(size(q,1),2)])*q(w(i).bodyj,6)^2 - rot(q(size(q,1),3))*w(i).sA*(q(w(i).bodyj,6) - q(size(q,1),6))^2) + eval(w(i).funbis);
                n = n + 3;
            end
        end
    elseif (any(w(i).bodyi == 1:length(q)))
            if(w(i).typ(1:4) == 'kine')
                if (w(i).klasa(1:4) == 'obro')
                    %rownanie 2.42
                    acc(n+1:n+2) = rot(q(w(i).bodyi,3))*w(i).sA*q(w(i).bodyi,6)^2 - rot(q(w(i).bodyj,3))*w(i).sB*q(w(i).bodyj,6)^2;
                    n = n + 2;
                elseif (w(i).klasa(1:4) == 'post')
                    %rownanie 2.48 i 2.59
                    acc(n+1:n+2) = [0; (rot(q(w(i).bodyj,3))*w(i).v)'*(2*omega*([q(w(i).bodyj,4); q(w(i).bodyj,5)] - [q(w(i).bodyi,4); q(w(i).bodyi,5)])*q(w(i).bodyj,6) + ([q(w(i).bodyj,1); q(w(i).bodyj,2)] - [q(w(i).bodyi,1); q(w(i).bodyi,2)])*q(w(i).bodyj,6)^2 - rot(q(w(i).bodyi,3))*w(i).sA*(q(w(i).bodyj,6) - q(w(i).bodyi,6))^2)];
                    n = n + 2;
                end
            elseif (w(i).typ(1:4) == 'kier')
                if (w(i).klasa(1:4) == 'post')
                    %rownanie 2.59 i 2.59 z uwzglednieniem pochodnej tt
                    acc(n+1:n+2) = [0; (rot(q(w(i).bodyj,3))*w(i).v)'*(2*omega*([q(w(i).bodyj,4); q(w(i).bodyj,5)] - [q(w(i).bodyi,4); q(w(i).bodyi,5)])*q(w(i).bodyj,6) + ([q(w(i).bodyj,1); q(w(i).bodyj,2)] - [q(w(i).bodyi,1); q(w(i).bodyi,2)])*q(w(i).bodyj,6)^2 - rot(q(w(i).bodyi,3))*w(i).sA*(q(w(i).bodyj,6) - q(w(i).bodyi,6))^2)];
                    acc(n+3) = (rot(q(w(i).bodyj,3))*w(i).u)'*(2*omega*([q(w(i).bodyj,4); q(w(i).bodyj,5)] - [q(w(i).bodyi,4); q(w(i).bodyi,5)])*q(w(i).bodyj,6) + ([q(w(i).bodyj,1); q(w(i).bodyj,2)] - [q(w(i).bodyi,1); q(w(i).bodyi,2)])*q(w(i).bodyj,6)^2 - rot(q(w(i).bodyi,3))*w(i).sA*(q(w(i).bodyj,6) - q(w(i).bodyi,6))^2) + eval(w(i).funbis);
                    n = n + 3;
                end
            end
    end
end

end