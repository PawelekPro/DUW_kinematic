function Jacob = Jacob(w,q,t)
% macierz Omega
omega = [0 -1; 1 0];
%macierz jednostkowa
I = eye(2);

n = 0;
Jacob = zeros(3*(size(q,1)-1));

 for i = 1:length(w)
    if (w(i).bodyi == 0)
        if (w(i).typ(1:4) == 'kine')
            if (w(i).klasa(1:4) == 'obro')
                %rownania 2.31-2.34
                tmp = [I, omega*q(size(q,1),3)*w(i).sA, -eye(2), -omega*rot(q(w(i).bodyj,3))*w(i).sB];
                Jacob(n+1:n+2,3*w(i).bodyj-2:3*w(i).bodyj) = tmp(:,4:6);
                n = n + 2;
            elseif (w(i).klasa(1:4) == 'post')
                %rownania 2.43-2.46
                %sprawdzic poprawnosc oraz 2.49-2.52 
                tmp1 = [[0 0 1 0 0 -1]; -(rot(q(w(i).bodyj,3))*w(i).v)', -(rot(q(w(i).bodyj,3))*w(i).v)'*omega*rot(q(size(q,1),3))*w(i).sA, (rot(q(w(i).bodyj,3))*w(i).v)', -(rot(q(w(i).bodyj,3))*w(i).v)'*omega*([q(w(i).bodyj,1); q(w(i).bodyj,2)] - [q(size(q,1),1); q(size(q,1),2)] - rot(q(size(q,1),3))*w(i).sA)];
                Jacob(n+1:n+2,3*w(i).bodyj-2:3*w(i).bodyj) = tmp1(:,4:6);
                n = n + 2;
            end
        elseif (w(i).typ(1:4) == 'kier')
            if (w(i).klasa(1:4) == 'post')
                %rownania 2.43-2.46 oraz 2.49-2.52 
                tmp2 = [[0 0 1 0 0 -1]; -(rot(q(w(i).bodyj,3))*w(i).v)', -(rot(q(w(i).bodyj,3))*w(i).v)'*omega*rot(q(size(q,1),3))*w(i).sA, (rot(qj(3))*w.v)', -(rot(q(w(i).bodyj,3))*w(i).v)'*omega*([q(w(i).bodyj,1); q(w(i).bodyj,2)] - [q(size(q,1),1); q(size(q,1),2)] - rot(q(size(q,1),3))*w(i).sA)];
                %rownania 2.49-2.52, ale zamiast wersora v używamy u
                tmp3 = [-(rot(q(w(i).bodyj,3))*w(i).u)', -(rot(q(w(i).bodyj,3))*w(i).u)'*omega*rot(q(size(q,1),3))*w(i).sA, (rot(q(w(i).bodyj,3))*w(i).u)', -(rot(q(w(i).bodyj,3))*w(i).u)'*omega*([q(w(i).bodyj,1); q(w(i).bodyj,2)] - [q(size(q,1),1); q(size(q,1),2)] - rot(q(size(q,1),3))*w(i).sA)];
                Jacob(n+1:n+2,3*w(i).bodyj-2:3*w(i).bodyj) = tmp2(:,4:6);
                Jacob(n+3,3*w(i).bodyj-2:3*w(i).bodyj) = tmp3(4:6);
                n = n + 3;
            else
                error('Program nie obsluguje wiezow kierujacych inne niz postepowe')
            end
        end
    elseif (any(w(i).bodyi == 1:length(q)))
        if (w(i).typ(1:4) == 'kine')
            if (w(i).klasa(1:4) == 'obro')
                %rownania 2.31-2.34
                tmp4 = [I, omega*rot(q(w(i).bodyi,3))*w(i).sA, -I, -omega*rot(q(w(i).bodyj,3))*w(i).sB];
                Jacob(n+1:n+2,3*w(i).bodyi-2:3*w(i).bodyi) = tmp4(:,1:3);
                Jacob(n+1:n+2,3*w(i).bodyj-2:3*w(i).bodyj) = tmp4(:,4:6);
                n = n + 2;
            elseif (w(i).klasa(1:4) == 'post')
                %rownania 2.43-2.46 i 2.49-2.52
                tmp5 = [[0 0 1 0 0 -1]; -(rot(q(w(i).bodyj,3))*w(i).v)', -(rot(q(w(i).bodyj,3))*w(i).v)'*omega*rot(q(w(i).bodyi,3))*w(i).sA, (rot(q(w(i).bodyj,3))*w(i).v)', -(rot(q(w(i).bodyj,3))*w(i).v)'*omega*([q(w(i).bodyj,1); q(w(i).bodyj,2)] - [q(w(i).bodyi,1); q(w(i).bodyi,2)] - rot(q(w(i).bodyi,3))*w(i).sA)];
                Jacob(n+1:n+2,3*w(i).bodyi-2:3*w(i).bodyi) = tmp5(:,1:3);
                Jacob(n+1:n+2,3*w(i).bodyj-2:3*w(i).bodyj) = tmp5(:,4:6);
                n = n + 2;
            end
        elseif (w(i).typ(1:4) == 'kier')
            if (w(i).klasa(1:4) == 'post')
                %rownania 2.43-2.46 oraz 2.49-2.52 
                tmp6 = [[0 0 1 0 0 -1]; -(rot(q(w(i).bodyj,3))*w(i).v)', -(rot(q(w(i).bodyj,3))*w(i).v)'*omega*rot(q(w(i).bodyi,3))*w(i).sA, (rot(q(w(i).bodyj,3))*w(i).v)', -(rot(q(w(i).bodyj,3))*w(i).v)'*omega*([q(w(i).bodyj,1); q(w(i).bodyj,2)] - [q(w(i).bodyi,1); q(w(i).bodyi,2)] - rot(q(w(i).bodyi,3))*w(i).sA)];
                %rownania 2.49-2.52, ale zamiast wersora v używamy u
                tmp7 = [-(rot(q(w(i).bodyj,3))*w(i).u)', -(rot(q(w(i).bodyj,3))*w(i).u)'*omega*rot(q(w(i).bodyi,3))*w(i).sA, (rot(q(w(i).bodyj,3))*w(i).u)', -(rot(q(w(i).bodyj,3))*w(i).u)'*omega*([q(w(i).bodyj,1); q(w(i).bodyj,2)] - [q(w(i).bodyi,1); q(w(i).bodyi,2)] - rot(q(w(i).bodyi,3))*w(i).sA)];
                Jacob(n+1:n+2,3*w(i).bodyi-2:3*w(i).bodyi) = tmp6(:,1:3);
                Jacob(n+1:n+2,3*w(i).bodyj-2:3*w(i).bodyj) = tmp6(:,4:6);
                Jacob(n+3,3*w(i).bodyi-2:3*w(i).bodyi) = tmp7(1:3);
                Jacob(n+3,3*w(i).bodyj-2:3*w(i).bodyj) = tmp7(4:6);
                n = n + 3;
            end
        end
    end
end
end