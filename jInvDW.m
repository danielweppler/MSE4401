function s = jInvDW(J, v)

jinv = inv(J(1:3,1:3))

qd=jinv*v
