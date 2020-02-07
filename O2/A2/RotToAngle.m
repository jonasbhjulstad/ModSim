function [vec, angle] = RotToAngle(RotMat)
    
    %Get Axis of rotation and angle from matrix:
    [eigvecs, eigvals] = eig(RotMat)
    [row, col] = find(eigvals==1);
    
    vec = eigvecs(:,col);
    
    angle = acos((trace(RotMat)-1)/2);
    
end
