CALL create_departamento('{"nome":"Contabilidade"}') ;
CALL create_departamento('{"nome":"WEB Develop"}') ;
CALL read_departamento('{"id":"1"}')
CALL read_departamento('{}')
call delete_departamento('{"id":"1"}') 
CALL update_departamento('{"id":"2","nome":"VIEW MODEL 2"}') 



#'{"nome":"Manoel vitor","cpf":"61233121201","rg":"1231313131","sexo":"M","possui_habilitacao":"1","carga_horaria_semanal":"40","id_departamento":"2"}'
CALL create_funcionario('{"nome":"Manoel vitor","cpf":"61233121201","rg":"1231313131","sexo":"M","possui_habilitacao":"1","valor_salario":"2500","carga_horaria_semanal":"40","id_departamento":"2"}');
CALL create_funcionario('{"nome":"Bruno oliveira","cpf":"51233121201","rg":"1331313131","sexo":"M","possui_habilitacao":"1","valor_salario":"4500","carga_horaria_semanal":"45","id_departamento":"1"}');
CALL create_funcionario('{"nome":"test","cpf":"51233121203","rg":"1231313132","sexo":"f","possui_habilitacao":"1","valor_salario":"4500","carga_horaria_semanal":"100","id_departamento":"1"}');


CALL read_funcionario('{}') ;
CALL read_funcionario('{"id":"4"}') ;


CALL update_funcionario('{"id":"1","nome":"Manoel vitor S R","cpf":"61233121201","rg":"1231313131","sexo":"M","possui_habilitacao":"0","valor_salario":"3500","carga_horaria_semanal":"35","id_departamento":"1"}');

CALL delete_funcionario('{"id":"7"}');

CALL create_projeto('{"id_departamento":"1","nome":"Site da WEB 1.0","total_horas_para_concluir":"220","id_funcionario":"1","carga_horaria":"8"}'); 
CALL create_projeto('{"id_departamento":"2","nome":"Site da WEB 3.0","total_horas_para_concluir":"120","id_funcionario":"4","carga_horaria":"15"}');

CALL update_projeto('{"id":"1","id_departamento":"1","nome":"Criar Agent","total_horas_para_concluir":"320","id_supervisor_projeto":"3","id_funcionario":"1","carga_horaria":"30"}');
CALL update_projeto('{"id":"8","id_departamento":"1","nome":"Site da WEB 1.2","total_horas_para_concluir":"225","id_supervisor_projeto":"10","id_funcionario":"4","carga_horaria":"5"}');

CALL add_funcionario_projeto('{"id_funcionario":"1","id_projeto":"1","carga_horaria":"30"}');
CALL add_funcionario_projeto('{"id_funcionario":"4","id_projeto":"1","carga_horaria":"25"}');
CALL add_funcionario_projeto('{"id_funcionario":"1","id_projeto":"3","carga_horaria":"5"}');

CALL remove_funcionario_projeto('{"id":"7"}') ;

CALL calculo_horas_realizada_projeto('{"id":"1"}');

CALL prazo_estimado_projeto('{"id":"1"}');