%%%%%%%%%%%%%% IKM conf=ikm(pose) %%%%%%%%%%%%%%%%

function [conf1,conf2]=ikm(pose)

global Ss; global Cs;
global rh;

x=pose(1);y=pose(2);z=pose(3);
sing=0;

q3=rh-sqrt(x^2+y^2+z^2);

if norm(q3-rh)<1e-8
    error('No solution to the IKM, singularity type 1: rh-sqrt(x^2+y^2+z^2)')
else
    
    C2=(Cs(1)*Cs(2)-z/(q3-rh))/(Ss(1)*Ss(2));

    % some precuations with numerical rounding
    if (C2>1)
        C2=1;
    else if (C2<-1)
            C2=-1;
        end
    end

    for i=[1,2]
        eps2=(-1)^i;
        S2=eps2*sqrt(1-C2^2);
        q2(i)=atan2(S2,C2);

        D1=-S2*Ss(2);
        D4=Cs(1)*C2*Ss(2)+Ss(1)*Cs(2);

        tmp_det=-(D1^2+D4^2);
        if tmp_det==0
            error('No solution to the IKM, singularity type 2: D1^2+D4^2=0')
        else
            tmp=1/tmp_det*[D4,-D1;-D1,-D4]*1/(q3-rh)*[x;y];
            q1(i)=atan2(tmp(1),tmp(2));
        end
    end
    
conf1=[q1(1),q2(1),q3];
conf2=[q1(2),q2(2),q3];

end



