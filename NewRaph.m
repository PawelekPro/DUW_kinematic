function q=NewRaph(w,q,t)
%   q0 - przybliżenie startowe,
%   t - chwila, dla której poszukiwane jest rozwiązanie.
% Wyjście:
%   q - uzyskane rozwiązanie.

qtmp = q(1:end-1,1:3)';
qtmp = qtmp(:);
F = Fi(w,q,t);
limit_iteracji = 500;


iter=1; % Licznik iteracji
while ( (norm(F)>1e-15) & (iter < limit_iteracji) )
    F = Fi(w,q,t);
    J = Jacob(w,q,t);
    %%Sprawdzanie uwarunkwoania macierzy
    uwarunkowanie = cond(J);
    if (uwarunkowanie > (1e10))
        disp('!!! Macierz Jacobiego jest źle uwarunkowana !!!');
    end

    %%Sprawdzanie osobliwości macierzy Jacobiego (jeden z podpunktów polecenia)
    wyznacznik = det(J);
    if (wyznacznik == 0)
        disp('!!! Macierz Jacobiego jest osobliwa !!!');
    end
       

        qtmp = qtmp - (J\F);
        q(1:end-1,1:3) = reshape(qtmp,[3,size(q,1)-1])';
%     q=q-J\F; % Fq\F jest równoważne inv(Fq)*F, ale mniej kosztowne numerycznie
    iter=iter+1;
end

if iter >= limit_iteracji
    disp('BŁĄD: Przekroczono limit iteracji i nie uzyskano zbieżności ');
end







