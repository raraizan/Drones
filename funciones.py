from numpy import *
from matplotlib.pyplot import *
from scipy.integrate import *
from mpl_toolkits.mplot3d import Axes3D

g = 9.81
m = 0.468
l = 0.225
k = 2.980e-6
b = 1.140e-7
I_m = 3.357e-5
Ixx = 4.856e-3
Iyy = 4.856e-3
Izz = 8.801e-3
Ax = 0.25
Ay = 0.25
Az = 0.25

kdT, kpT = 1.5, 4.0
kdtx, kptx = 1., 5.
kdty, kpty = kdtx, kptx
kdtz, kptz = 1.5, 15.0

def C(state):cd Dev
    
    ax, ay, az = state[6:9]
    dx, dy, dz = state[9:12]
    
    C = zeros([3, 3])
    C[0][0] = 0
    C[0][1] = (Iyy - Izz) * (dy * cos(ax) * sin(ax) + dz * sin(ax)**2 * cos(ay)) + (Izz - Iyy) * dz * cos(ax)**2 * cos(ay) - Ixx * dz * cos(dy)
    C[0][2] = (Izz - Iyy) * dz * cos(ax) * sin(ax) * cos(ay)**2
    C[1][0] = (Izz - Iyy) * (dy * cos(ax) * sin(ax) + dz * sin(ax) * cos(ay)) + (Iyy - Izz) * dz * cos(ax)**2 * cos(ay) + Ixx * dz * cos(ay)
    C[1][1] = (Izz - Iyy) * dx * cos(ax) * sin(ax)
    C[1][2] = - Ixx * dz * sin(ay) * cos(ay) + Iyy * dz * sin(ax)**2 * sin(ay) * cos(ay) + Izz * dz * cos(ax)**2 * sin(ay) * cos(ay)
    C[2][0] = (Iyy - Izz) * dz * cos(ay)**2 * sin(ax) * cos(ax) - Ixx * dy * cos(ay)
    C[2][1] = (Izz - Iyy) * (dy * cos(ax) * sin(ax) * sin(ay) + dx * sin(ax)**2 * cos(ay)) + (Iyy - Izz) * dx * cos(ax)**2 * cos(ay) + Ixx * dz * sin(ay) * cos(ay) - Iyy * dz * sin(ax)**2 * sin(ay) * cos(ay) - Izz * dz * cos(ax)**2 * sin(ay) * cos(ay)
    C[2][2] = (Iyy - Izz) * dx * cos(ax) * sin(ax) * cos(ay)**2 - Iyy * dy * sin(ax)**2 * cos(ay) * sin(ay) - Izz * dy * cos(ax)**2 * cos(ay) * sin(ay) + Ixx * dy * cos(ay) * sin(ay)

    return C


def J_inv(state):
    ax, ay, az = state[6:9]
    dx, dy, dz = state[9:12]
    
    J = zeros([3, 3])
    J[0][0] = Ixx
    J[1][1] = Iyy * cos(ax)**2 + Izz * sin(ax)**2
    J[2][2] = Ixx * sin(ay)**2 + Iyy * sin(ax)**2 * cos(ay)**2 + Izz * cos(ax)**2 * cos(ay)**2
    
    J[0][1] = J[1][0] = 0
    J[0][2] = J[2][0] = - Ixx * sin(ay)
    J[1][2] = J[2][1] = (Iyy - Izz) * cos(ax) * sin(ax) * cos(ay)

    return linalg.inv(J)


def PD(state_1, state_2):
    
    z, dz = state_2[2] - state_1[2], state_2[5] - state_1[5]
    
    aa, ab, ac = state_2[6:9] - state_1[6:9]
    da, db, dc = state_2[9:12] - state_1[9:12]
    
    T = (g + kdT * (dz) + kpT * (z)) * m / (cos(state_1[6]) * cos(state_1[7]))
    tx = (kdtx * (da) + kptx * (aa)) * Ixx
    ty = (kdty * (db) + kpty * (ab)) * Iyy
    tz = (kdtz * (dc) + kptz * (ac)) * Izz
   
    return array([T, tx, ty, tz])


def omega2(state_1, state_2, t):
    
    T, tx, ty, tz = PD(state_1, state_2)

    w1 = abs(0.25 * T / k - 0.5 * ty / (k * l) - 0.25 * tz / b)
    w2 = abs(0.25 * T / k - 0.5 * tx / (k * l) + 0.25 * tz / b)
    w3 = abs(0.25 * T / k + 0.5 * ty / (k * l) - 0.25 * tz / b)
    w4 = abs(0.25 * T / k + 0.5 * tx / (k * l) + 0.25 * tz / b)

    return array([w1, w2, w3, w4])

#def omega2(state_1, state_2, t):
#    
#    w =  sqrt(0.25 * m * g / k) * ones([4])
#    
#    if t < 0.5:
#        w += 300.0 * sin(4. * pi * t) * array([1.0, 1.0, 1.0, 1.0])
#    elif t < 1.0:
#        pass
#    elif t < 1.5:
#        w += 25.0 * sin(4. * pi * t) * array([-1.0, 1.0, -1.0, 1.0]) - 37 * array([1., 1., 1., 1.])
#    elif t < 2.0:
#        pass
#    elif t < 2.5:
#        w -= 400.0 * sin(4 * pi * t) * array([1.0, -1.0, -1.0, 1.0]) - 50 * array([1., 1., 1., 1.])
#    elif t < 3.0:
#        w += 400.0 * sin(4 * pi * t) * array([1.0, -1.0, -1.0, 1.0]) - 175 * array([1., 1., 1., 1.])
#    elif t < 3.5:
#        w += 400.0 * sin(4 * pi * t) * array([1.0, -1.0, -1.0, 1.0]) - 175 * array([1., 1., 1., 1.])
#    elif t < 4.0:
#        w -= 400.0 * sin(4 * pi * t) * array([1.0, -1.0, -1.0, 1.0]) - 50 * array([1., 1., 1., 1.])
#
#    return w**2

def T(w2):
    F = w2[0] + w2[1] + w2[2] + w2[3]
    return k * F


def Tau(w2):
    Tau = array([l * k * (-sqrt(w2[1]) + sqrt(w2[3])),
                 l * k * (-sqrt(w2[0]) + sqrt(w2[2])),
                 b * (-w2[0] + w2[1] - w2[2] + w2[3])])
    return Tau