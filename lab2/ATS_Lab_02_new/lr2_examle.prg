' NTUU-KPI dep. IASA. Terentyev Alexandr Nikolaevich. Kiev-2008.
'
'-------- ������� ������� ������������ ���������� � ��������� ------
'  ������ ������������ ������� �� ���� 
' 100 0.005 1 0 0.15 -0.33 0.25 1 0
'
'  ������ ������������ ������� �� ���� 
' 100 0.2 2 0 0.15 -0.33 0.25 1 0
'
'  ������ ��������������� ������� �� ���� 
' 100 2 3 0 0.15 -0.33 0.25 1 0
'
' --------- �������� ������� ���������� -----------------
' %0  -  ����� ������
' %1  -  ��������� ����
' %2  -  ��� �������� ������� 1 - nrnd, 2 - rnd, 3 - sin 
' %3  -  ����������� �0
' %4  -  ����������� �1
' %5  -  ����������� �2
' %6  -  ����������� �3
' %7  -  ����������� b1
' %8  -  ����������� b2

' ------ �������� �������� ����� ----------------------------------------
' workfile <��� ���������> <��� ������> <����� ������>
'' ��� ��������� LR2
' ����� ������ ���������� ���������� %0
' ���� ������:
' u - Undated or irregular.

workfile LR2 u %0
range 1 {%0}
smpl 1 {%0}

' ����� �������� %1 ������ ��������� ����
scalar disp={%1}
' ������������� �������� �������
if {%2}=1 then series e=nrnd*disp endif
if {%2}=2 then series e=rnd*disp endif
if {%2}=3 then 
   series e
   e(1)=0
   for !i=2 to {%0}
     e(!i)=e(!i-1)+(6*3.141592653)/{%0}
  next
  e=sin(e)*disp
endif

' ������������� ������������������
' y(k)=a0+a1*y(k-1)+a2*y(k-2)+a3*y(k-3)+e(k)+b1*e(k-1)+b2*e(k-2)
' � �������������� 
' �0=0
' �1 = 0.15
' �2=-0.33
' �3=0.25
' b1=1
' b2=0

scalar a0={%3}
scalar a1={%4}
scalar a2={%5}
scalar a3={%6}
scalar b1={%7}
scalar b2={%8}

' ������ ��������� �������� ���� �
series y
y(1)=e(1)
y(2)=e(2)
y(3)=e(3)

for !i=4 to {%0}
    y(!i)=a0+a1*y(!i-1)+a2*y(!i-2)+a3*y(!i-3)+e(!i)+b1*e(!i-1)+b2*e(!i-2)
next

plot y e

