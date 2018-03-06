update MPSCFTAB set cfvalue='-d -C -t 20091201' where cfcode=23;
update USERLBL set ulnff1=30 where ultag='SETTLING_LEN';
commit;
