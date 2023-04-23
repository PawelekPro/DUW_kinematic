function Fi = Fi(w,q,t)

n = 0;
Fi = zeros(3*(size(q,1)-1),1);
for i = 1:length(w)
    if (w(i).bodyi == 0)
        if (w(i).typ(1:4) == 'kine')
            if (w(i).klasa(1:4) == 'obro')
                %rownanie 2.18
                Fi(n+1:n+2) = [q(size(q,1),1); q(size(q,1),2)] + rot(q(size(q,1),3))*w(i).sA-([q(w(i).bodyj,1); q(w(i).bodyj,2)] + rot(q(w(i).bodyj,3))*w(i).sB);
                n = n + 2;
            end
            elseif (w(i).klasa(1:4) == 'post')
                %rownanie 2.19 i 2.22
                Fi(n+1:n+2) = [q(size(q,1),3) - q(w(i).bodyj,3) - w(i).fi0; 
                    (rot(q(w(i).bodyj,3))*w(i).v)'*([q(w(i).bodyj,1); q(w(i).bodyj,2)] - [q(size(q,1),1); q(size(q,1),2)] - rot(q(size(q,1),3))*w(i).sA) + w(i).v'*w(i).sB];
                n = n + 2;
         elseif (w(i).typ(1:4) == 'kier')
            if (w(i).klasa(1:4) == 'post')
                %rownanie 2.19 i 2.22
                Fi(n+1:n+2) = [q(size(q,1),3) - q(w(i).bodyj,3) - w(i).fi0; 
                    (rot(q(w(i).bodyj,3))*w(i).v)'*([q(w(i).bodyj,1); q(w(i).bodyj,2)] - [q(size(q,1),1); q(size(q,1),2)] - rot(q(size(q,1),3))*w(i).sA) + w(i).v'*w(i).sB];
                %rownanie 2.28
                Fi(n+3) = (rot(q(w(i).bodyj,3))*w(i).u)'*([q(w(i).bodyj,1); q(w(i).bodyj,2)] + rot(q(w(i).bodyj,3))*w(i).sB - [q(size(q,1),1); q(size(q,1),2)] - rot(q(size(q,1),3))*w(i).sA) - eval(w(i).fun);
                n = n + 3;
            else
                error('Program nie obsluguje wiezow kierujacych inne niz postepowe')
            end     
        end
    elseif (any(w(i).bodyi == 1:length(q)))
        if (w(i).typ(1:4) == 'kine')
            if (w(i).klasa(1:4) == 'obro')
                %rownanie 2.18
                Fi(n+1:n+2) = [q(w(i).bodyi,1); q(w(i).bodyi,2)] + rot(q(w(i).bodyi,3))*w(i).sA-([q(w(i).bodyj,1); q(w(i).bodyj,2)] + rot(q(w(i).bodyj,3))*w(i).sB);
                n = n + 2;
            elseif (w(i).klasa(1:4) == 'post')
                %rownanie 2.19 i 2.22
                Fi(n+1:n+2) = [q(w(i).bodyi,3) - q(w(i).bodyj,3) - w(i).fi0; (rot(q(w(i).bodyj,3))*w(i).v)'*([q(w(i).bodyj,3); q(w(i).bodyj,2)] - [q(w(i).bodyi,1); q(w(i).bodyi,2)] - rot(q(w(i).bodyi,3))*w(i).sA) + w(i).v'*w(i).sB];
                n = n + 2;
            end
        elseif (w(i).typ(1:4) == 'kier')
            if (w(i).klasa(1:4) == 'post')
                %rownanie 2.19 i 2.22
                Fi(n+1:n+2) = [q(w(i).bodyi,3) - q(w(i).bodyj,3) - w(i).fi0; (rot(q(w(i).bodyj,3))*w(i).v)'*([q(w(i).bodyj,1); q(w(i).bodyj,2)] - [q(w(i).bodyi,1); q(w(i).bodyi,2)] - rot(q(w(i).bodyi,3))*w(i).sA) + w(i).v'*w(i).sB];
                %rownanie 2.28
                Fi(n+3) = (rot(q(w(i).bodyj,3))*w(i).u)'*([q(w(i).bodyj,1); q(w(i).bodyj,2)] + rot(q(w(i).bodyj,3))*w(i).sB - [q(w(i).bodyi,1); q(w(i).bodyi,2)] - rot(q(w(i).bodyi,3))*w(i).sA) - eval(w(i).fun);
                n = n + 3;
            end
        end
    end
end
end

