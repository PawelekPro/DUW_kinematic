function [w,q] = PobierzDane()

%wczytywanie współrzędnych punktów z polecenia
A = [0; 0];
B = [0.3; 0];
D = [0.2; 0.6];
E = [-0.1; 0.7];
F = [-0.2; 0.8];
G = [0; 1.2];
H = [0.5; 0.8];
I = [0.5; -0.1];
J = [0.7; 0.3];
K = [0.8; 0.6];
L = [1; -0.5];
M = [1.3; -0.3];
N = [1.3; 0];

%wczytywanie współrzędnych środków ciężkości z polecenia
c1 = [0; 0.85];
c2 = [0.4; 0.75];
c3 = [0.15; 0.45];
c4 = [0.05; 0.15];
c5 = [0.45; 0.6];
c6 = [0.35; 0.2];
c7 = [0.4; 0.1];
c8 = [0.65; 0.25];
c9 = [1.05; 0.3];
c10 = [1.2; -0.25];

q(1,:) = [c1; 0];
q(2,:) = [c2; 0];
q(3,:) = [c3; 0];
q(4,:) = [c4; 0];
q(5,:) = [c5; 0];
q(6,:) = [c6; 0];
q(7,:) = [c7; 0];
q(8,:) = [c8; 0];
q(9,:) = [c9; 0];
q(10,:) = [c10; 0];
q(11,:) = [0; 0; 0];
q = [q, zeros(size(q,1),6)];

% macierz Omega
omega = [0 -1; 1 0];

%deklaracja struktury
wiezy = struct('bodyi',{},'bodyj',{},'typ',{},...
'klasa',{},'sA',{},'sB',{},'fi0',{},'v',{},'u',{},...
'fun',{},'funprim',{},'funbis',{},'point_name',{});

%przypisanie wszystkich rodzajów więzów do elementów struktury
w(1)=cell2struct({0,1,'kinematyczny', 'obrotowy',  E, E-c1, [], [], [], [], [], [],'E'}',fieldnames(wiezy));
w(2)=cell2struct({0,4,'kinematyczny', 'obrotowy',  A, A-c4, [], [], [], [], [], [],'A'}',fieldnames(wiezy));
w(3)=cell2struct({0,6,'kinematyczny', 'obrotowy',  B, B-c6, [], [], [], [], [], [],'B'}',fieldnames(wiezy));
w(4)=cell2struct({1,2,'kinematyczny', 'obrotowy',  G-c1, G-c2, [], [], [], [], [], [],'G'}',fieldnames(wiezy));
w(5)=cell2struct({1,3,'kinematyczny', 'obrotowy',  D-c1, D-c3, [], [], [], [], [], [],'D'}',fieldnames(wiezy));
w(6)=cell2struct({1,7,'kinematyczny', 'obrotowy',  F-c1, F-c7, [], [], [], [], [], [],'F'}',fieldnames(wiezy));
w(7)=cell2struct({2,8,'kinematyczny', 'obrotowy',  J-c2, J-c8, [], [], [], [], [], [],'J'}',fieldnames(wiezy));
w(8)=cell2struct({2,5,'kinematyczny', 'obrotowy',  H-c2, H-c5, [], [], [], [], [], [],'H'}',fieldnames(wiezy));
w(9)=cell2struct({7,8,'kinematyczny', 'obrotowy',  I-c7, I-c8, [], [], [], [], [], [],'I'}',fieldnames(wiezy));
w(10)=cell2struct({7,10,'kinematyczny', 'obrotowy', L-c7, L-c10, [], [], [], [], [], [],'L'}',fieldnames(wiezy));
w(11)=cell2struct({8,9,'kinematyczny', 'obrotowy',  K-c8, K-c9, [], [], [], [], [], [],'K'}',fieldnames(wiezy));
w(12)=cell2struct({9,10,'kinematyczny', 'obrotowy',  N-c9, N-c10, [], [], [], [], [], [],'N'}',fieldnames(wiezy));
w(13)=cell2struct({3,4,'kierujacy', 'postepowy',  D-c3, c4-A, 0, omega*((A-D)/norm(A-D)), (A-D)/norm(A-D),'sqrt(0.1^2+0.3^2) + 0.19*sin(t)', '0.19*cos(t)', '-0.19*sin(t)','0'}',fieldnames(wiezy));
w(14)=cell2struct({5,6,'kierujacy', 'postepowy',  H-c5, c6-B, 0, omega*((B-H)/norm(A-D)), (B-H)/norm(B-H),'sqrt(0.1^2+0.4^2) + 0.025*sin(0.7*t)', '0.025*0.7*cos(0.7*t)', '-0.025*0.7*0.7*sin(0.7*t)','0'}',fieldnames(wiezy));
end









