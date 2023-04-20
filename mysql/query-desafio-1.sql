
CREATE TABLE IF NOT EXISTS empresa.departamentos(
id int NOT NULL AUTO_INCREMENT,
nome  varchar(150) unique not null,
created_at timestamp default now(),
updated_at timestamp default now(),
primary key(id)
);

CREATE TABLE IF NOT EXISTS empresa.funcionarios(
id int NOT NULL AUTO_INCREMENT,
nome varchar(150) unique NOT NULL,
cpf varchar(11) unique NOT NULL,
rg varchar(13) unique NOT NULL,
sexo varchar(1) NOT NULL,
possui_habilitacao bool DEFAULT false,
valor_salario FLOAT DEFAULT 0 NOT NULL,
carga_horaria_semanal float  DEFAULT 0 NOT NULL,
id_departamento int NOT NULL,
created_at timestamp DEFAULT now(),
updated_at timestamp DEFAULT now(),
primary key(id)
);

CREATE TABLE IF NOT EXISTS empresa.projetos(
id int not null AUTO_INCREMENT,
id_departamento int not null,
nome varchar(150) not null,
total_horas_para_concluir float not null,
total_horas_realizadas float DEFAULT 0 NOT NULL  ,
data_prazo_estimado date,
id_supervisor_projeto int,
data_ultima_medicao date DEFAULT (CURRENT_DATE),
created_at timestamp default now(),
updated_at timestamp default now(),
primary key(id)
);

CREATE TABLE IF NOT EXISTS empresa.supervisor_projeto(
id int not null AUTO_INCREMENT,
id_funcionario int  not null,
carga_horaria float not null,
created_at timestamp default now(),
updated_at timestamp default now(),
primary key(id)
);


CREATE TABLE IF NOT EXISTS empresa.funcionario_projeto(
id SERIAL PRIMARY KEY,
id_funcionario int  not null,
id_projeto int not null,
carga_horaria float not null,
created_at timestamp default now(),
updated_at timestamp default now()
);



ALTER TABLE empresa.funcionarios
ADD FOREIGN KEY (id_departamento) REFERENCES empresa.departamentos(id);
#projeto
ALTER TABLE empresa.projetos ADD UNIQUE `unico_nome_id_departamento`(`nome`, `id_departamento`);

ALTER TABLE empresa.projetos
ADD FOREIGN KEY (id_departamento) REFERENCES empresa.departamentos(id);

ALTER TABLE empresa.projetos
ADD FOREIGN KEY (id_supervisor_projeto) REFERENCES empresa.supervisor_projeto(id);



ALTER TABLE empresa.supervisor_projeto
ADD FOREIGN KEY (id_funcionario) REFERENCES empresa.funcionarios(id);


ALTER TABLE empresa.funcionario_projeto
ADD FOREIGN KEY (id_funcionario) REFERENCES empresa.funcionarios(id);

ALTER TABLE empresa.funcionario_projeto
ADD FOREIGN KEY (id_projeto) REFERENCES empresa.projetos(id);

ALTER TABLE empresa.funcionario_projeto ADD UNIQUE `funcionario_projeto_unique_const`(`id_funcionario`, `id_projeto`);



CREATE PROCEDURE IF NOT EXISTS empresa.create_departamento(IN data JSON)
	BEGIN
			DECLARE nome VARCHAR(150) default null;
			SET nome = json_unquote(json_extract(data,'$.nome')); 
			insert into departamentos(nome) values(nome);
	END;
	
CREATE PROCEDURE IF NOT EXISTS empresa.update_departamento(IN data JSON)
	BEGIN
			DECLARE id int default null;
			DECLARE nome1 VARCHAR(150) default null;
			SET id = json_unquote(json_extract(data,'$.id')); 
			SET nome1 = json_unquote(json_extract(data,'$.nome')); 
		
			update departamentos d 
			set nome = nome1, updated_at = now()
			where d.id = id;
	END;

CREATE PROCEDURE IF NOT EXISTS empresa.delete_departamento(IN data JSON)
	BEGIN
			DECLARE id int default null;			
			SET id = json_unquote(json_extract(data,'$.id')); 
			delete from departamentos d where d.id = id;
	END;

CREATE PROCEDURE IF NOT EXISTS empresa.read_departamento(IN data JSON)
		BEGIN
				DECLARE id int default null;
				SET id = json_unquote(json_extract(data,'$.id')); 
				IF id is null THEN
			        select * from departamentos ;
			    ELSE
			        select * from departamentos d where d.id = id;
			    END IF;				
		END;




CREATE PROCEDURE IF NOT EXISTS empresa.create_funcionario(IN _data JSON)
	BEGIN
			DECLARE nome VARCHAR(150) DEFAULT  NULL;
			DECLARE cpf varchar(11) DEFAULT NULL;
			DECLARE rg varchar(13) DEFAULT NULL;
			DECLARE sexo varchar(1) DEFAULT NULL;
			DECLARE possui_habilitacao bool DEFAULT false;
			DECLARE valor_salario float DEFAULT 0 ;
			DECLARE carga_horaria_semanal float DEFAULT 0;
			DECLARE id_departamento int DEFAULT NULL;
		
			SET nome = json_unquote(json_extract(_data,'$.nome'));
			SET cpf = json_unquote(json_extract(_data,'$.cpf'));
			SET rg = json_unquote(json_extract(_data,'$.rg'));
			SET sexo = json_unquote(json_extract(_data,'$.sexo'));
			SET possui_habilitacao = json_unquote(json_extract(_data,'$.possui_habilitacao'));
			SET valor_salario = json_unquote(json_extract(_data,'$.valor_salario'));
			SET carga_horaria_semanal = json_unquote(json_extract(_data,'$.carga_horaria_semanal'));
			SET id_departamento = json_unquote(json_extract(_data,'$.id_departamento'));
		
			insert into funcionarios(nome,cpf,rg,sexo,possui_habilitacao,valor_salario,carga_horaria_semanal,id_departamento) 
			values(nome,cpf,rg,sexo,possui_habilitacao,valor_salario,carga_horaria_semanal,id_departamento);
	END;


CREATE PROCEDURE IF NOT EXISTS  empresa.read_funcionario(IN _data JSON)
		BEGIN
				DECLARE id int DEFAULT NULL;
				SET id = json_unquote(json_extract(_data,'$.id')); 
				IF id IS NULL THEN
			        SELECT * FROM funcionarios f ;
			    ELSE
			        SELECT * FROM funcionarios f WHERE f.id = id;
			    END IF;				
		END;

	

CREATE PROCEDURE IF NOT EXISTS empresa.update_funcionario(IN _data JSON)
	BEGIN
			DECLARE _id int DEFAULT NULL;
			DECLARE _nome VARCHAR(150) DEFAULT NULL;
			DECLARE _cpf varchar(11) DEFAULT NULL;
			DECLARE _rg varchar(13) DEFAULT NULL;
			DECLARE _sexo varchar(1) DEFAULT NULL;
			DECLARE _possui_habilitacao bool DEFAULT false;
			DECLARE _valor_salario float DEFAULT 0 ;
			DECLARE _carga_horaria_semanal float DEFAULT 0;
			DECLARE _id_departamento int DEFAULT NULL;
		
			SET _id = json_unquote(json_extract(_data,'$.id'));
			SET _nome = json_unquote(json_extract(_data,'$.nome'));
			SET _cpf = json_unquote(json_extract(_data,'$.cpf'));
			SET _rg = json_unquote(json_extract(_data,'$.rg'));
			SET _sexo = json_unquote(json_extract(_data,'$.sexo'));
			SET _possui_habilitacao = json_unquote(json_extract(_data,'$.possui_habilitacao'));
			SET _valor_salario = json_unquote(json_extract(_data,'$.valor_salario'));
			SET _carga_horaria_semanal = json_unquote(json_extract(_data,'$.carga_horaria_semanal'));
			SET _id_departamento = json_unquote(json_extract(_data,'$.id_departamento'));
		
			UPDATE funcionarios AS f
			SET nome = _nome ,cpf = _cpf, rg = _rg, sexo = _sexo , possui_habilitacao = _possui_habilitacao, valor_salario = _valor_salario, carga_horaria_semanal = _carga_horaria_semanal ,id_departamento = _id_departamento, updated_at = now()
			WHERE f.id = _id;
	END;





CREATE PROCEDURE IF NOT EXISTS empresa.delete_funcionario(IN _data JSON)
	BEGIN
			DECLARE id int DEFAULT NULL;			
			SET id = json_unquote(json_extract(_data,'$.id')); 
			DELETE FROM funcionarios f WHERE f.id = id;
	END;



#projeto CRUD PROCEDURE

CREATE PROCEDURE IF NOT EXISTS empresa.create_projeto(IN _data JSON)
	BEGIN
			
			DECLARE id_departamento int DEFAULT 0;
			DECLARE nome VARCHAR(150) DEFAULT  NULL;
			DECLARE total_horas_para_concluir float DEFAULT 0;
			DECLARE id_supervisor_projeto int DEFAULT 0;
			DECLARE id_funcionario int DEFAULT 0;
			DECLARE carga_horaria float DEFAULT 0;			
			DECLARE total_horas_trabalhadas_funcionario INT DEFAULT 0;
			DECLARE carga_horario_semanal_funcionario INT DEFAULT 0;
		
			DECLARE erro_sql TINYINT DEFAULT FALSE;
			DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET erro_sql = TRUE;
		
			SET id_departamento = json_unquote(json_extract(_data,'$.id_departamento'));
			SET nome = json_unquote(json_extract(_data,'$.nome'));
			SET total_horas_para_concluir = json_unquote(json_extract(_data,'$.total_horas_para_concluir'));
		
			SET id_funcionario = json_unquote(json_extract(_data,'$.id_funcionario'));
			SET carga_horaria = json_unquote(json_extract(_data,'$.carga_horaria'));
		
		
			SET total_horas_trabalhadas_funcionario = fn_total_horas_trabalhadas(id_funcionario);
			SET carga_horario_semanal_funcionario = (select f.carga_horaria_semanal  from funcionarios f where f.id = id_funcionario) ;
				
			IF carga_horario_semanal_funcionario IS NOT NULL AND (total_horas_trabalhadas_funcionario + carga_horaria) <= carga_horario_semanal_funcionario THEN
				SET @@AUTOCOMMIT = OFF;
				START TRANSACTION;		 		
					insert into supervisor_projeto(id_funcionario,carga_horaria) values(id_funcionario,carga_horaria);
					SET id_supervisor_projeto = LAST_INSERT_ID();
					insert into projetos(id_departamento,nome,total_horas_para_concluir,id_supervisor_projeto) 
					values(id_departamento,nome,total_horas_para_concluir,id_supervisor_projeto);
				IF erro_sql = FALSE THEN
					COMMIT;
					SELECT 'Transação realizada com sucesso.' AS Resultado;
				ELSE
				 	ROLLBACK;
				 	SELECT ' ERROR nat transação.' AS Resultado;  
				END IF;
				SET @@AUTOCOMMIT = ON;
				SELECT CONCAT('VALUES ',carga_horario_semanal_funcionario, ' total horas fun: ',total_horas_trabalhadas_funcionario, ' carga horaria ->',carga_horaria)  AS Status;
			ELSE 
				SELECT 'Não pode atribuir mais trabalho para esse funcionario.' AS Status;
			END IF;		
			
	END;





CREATE PROCEDURE IF NOT EXISTS empresa.delete_projeto(IN _data JSON)
	BEGIN
			DECLARE id int DEFAULT NULL;			
			SET id = json_unquote(json_extract(_data,'$.id')); 
			DELETE FROM projetos p WHERE p.id = id;
	END;

CREATE PROCEDURE IF NOT EXISTS empresa.read_projeto(IN _data JSON)
		BEGIN
				DECLARE id int DEFAULT NULL;
				SET id = json_unquote(json_extract(_data,'$.id')); 
				IF id IS NULL THEN
			        SELECT * FROM projetos;
			    ELSE
			        SELECT * FROM projetos p WHERE p.id = id;
			    END IF;				
		END;
	
CREATE PROCEDURE IF NOT EXISTS empresa.update_projeto(IN _data JSON)
	BEGIN
			DECLARE _id int DEFAULT 0; 
			DECLARE _id_departamento int DEFAULT 0;
			DECLARE _nome VARCHAR(150) DEFAULT  NULL;
			DECLARE _total_horas_para_concluir float DEFAULT 0;
			DECLARE _id_supervisor_projeto int DEFAULT 0;
			DECLARE _id_funcionario int DEFAULT 0;
			DECLARE _carga_horaria float DEFAULT 0;
			DECLARE total_horas_trabalhadas_funcionario INT DEFAULT 0;
			DECLARE carga_horario_semanal_funcionario INT DEFAULT 0;
			DECLARE carga_horario_supervisio_projeto INT DEFAULT 0;
			DECLARE superv_atual_id INT DEFAULT 0;
			DECLARE temp INT DEFAULT 0;
		
			DECLARE erro_sql TINYINT DEFAULT FALSE;
			DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET erro_sql = TRUE;
			SET _id = json_unquote(json_extract(_data,'$.id'));
			SET _id_departamento = json_unquote(json_extract(_data,'$.id_departamento'));
			SET _nome = json_unquote(json_extract(_data,'$.nome'));
			SET _total_horas_para_concluir = json_unquote(json_extract(_data,'$.total_horas_para_concluir'));
		
			SET _id_supervisor_projeto = json_unquote(json_extract(_data,'$.id_supervisor_projeto'));
			SET _id_funcionario = json_unquote(json_extract(_data,'$.id_funcionario'));
			SET _carga_horaria = json_unquote(json_extract(_data,'$.carga_horaria'));
		
			SET total_horas_trabalhadas_funcionario = fn_total_horas_trabalhadas(_id_funcionario);
			SET carga_horario_semanal_funcionario = (select f.carga_horaria_semanal  from funcionarios f where f.id = _id_funcionario) ;
		
			SET superv_atual_id = (select sp.id_funcionario  from supervisor_projeto sp where sp.id = _id_supervisor_projeto);
			IF superv_atual_id = _id_funcionario THEN
				SET carga_horario_supervisio_projeto = (select sp.carga_horaria  from supervisor_projeto sp where sp.id = _id_supervisor_projeto);
				SET temp = (total_horas_trabalhadas_funcionario - carga_horario_supervisio_projeto);
				SET total_horas_trabalhadas_funcionario = temp;
			END IF;
			
		
			IF carga_horario_semanal_funcionario IS NOT NULL AND (total_horas_trabalhadas_funcionario + _carga_horaria) <= carga_horario_semanal_funcionario THEN
				SET @@AUTOCOMMIT = OFF;
				START TRANSACTION;		 		
					UPDATE supervisor_projeto AS sp
					SET id_funcionario = _id_funcionario, carga_horaria = _carga_horaria, updated_at = now()
					WHERE sp.id = _id_supervisor_projeto;
					
					UPDATE projetos AS p 
					SET id_departamento = _id_departamento ,nome = _nome ,total_horas_para_concluir = _total_horas_para_concluir, updated_at = now() 
					WHERE p.id = _id;
				
				IF erro_sql = FALSE THEN
					COMMIT;
					SELECT 'Transação realizada com sucesso.' AS Resultado;
				ELSE
				 	ROLLBACK;
				 	SELECT ' ERROR nat transação.' AS Resultado;  
				END IF;
				SET @@AUTOCOMMIT = ON;
			ELSE 
				SELECT 'Não pode atribuir mais trabalho para esse funcionario.' AS Status;
			END IF;
			
	END;


 
CREATE PROCEDURE IF NOT EXISTS empresa.add_funcionario_projeto(IN _data JSON)
	BEGIN
			
			DECLARE id_funcionario int DEFAULT 0;
			DECLARE id_projeto int DEFAULT  0;
			DECLARE carga_horaria float DEFAULT 0;
		
			DECLARE total_horas_trabalhadas_funcionario INT DEFAULT 0;
			DECLARE carga_horario_semanal_funcionario INT DEFAULT 0;
		
			SET id_funcionario = json_unquote(json_extract(_data,'$.id_funcionario'));
			SET id_projeto = json_unquote(json_extract(_data,'$.id_projeto'));
			SET carga_horaria = json_unquote(json_extract(_data,'$.carga_horaria'));
		
		 	SET total_horas_trabalhadas_funcionario = fn_total_horas_trabalhadas(id_funcionario);
			SET carga_horario_semanal_funcionario = (select f.carga_horaria_semanal  from funcionarios f where f.id = id_funcionario) ;
		
			IF carga_horario_semanal_funcionario IS NOT NULL AND (total_horas_trabalhadas_funcionario + carga_horaria) <= carga_horario_semanal_funcionario THEN
				insert into funcionario_projeto(id_funcionario,id_projeto,carga_horaria) 
				values(id_funcionario,id_projeto,carga_horaria);
				SELECT CONCAT('VALUES ',carga_horario_semanal_funcionario, ' total horas fun: ',total_horas_trabalhadas_funcionario, ' carga horaria ->',carga_horaria)  AS Status;
			ELSE 
				SELECT 'Não pode atribuir mais trabalho para esse funcionario.' AS Status;
			END IF;
	END;




CREATE PROCEDURE IF NOT EXISTS empresa.remove_funcionario_projeto(IN _data JSON)
	BEGIN
			
		DECLARE id int DEFAULT 0;
	
		SET id = json_unquote(json_extract(_data,'$.id'));
	 
		DELETE FROM funcionario_projeto fp
		WHERE fp.id = id;
	END;




CREATE FUNCTION fn_total_horas_trabalhadas(id_funcionario INT) RETURNS FLOAT DETERMINISTIC
BEGIN
	DECLARE total_horas_trabalhadas INT DEFAULT 0;

	SET total_horas_trabalhadas = COALESCE((SELECT (SELECT  sum(sp.carga_horaria)AS "total_horas_sup" FROM supervisor_projeto sp
														WHERE sp.id_funcionario = id_funcionario)+(SELECT  sum(fp.carga_horaria) AS "total_horas_trab" FROM funcionario_projeto fp 
														WHERE fp.id_funcionario = id_funcionario)),0) ;
													
	RETURN total_horas_trabalhadas;
	 
END;

#select fn_total_horas_trabalhadas(4) ;

CREATE FUNCTION fn_total_horas_trabalhadas_projeto(id_projeto INT) RETURNS FLOAT DETERMINISTIC
BEGIN
	DECLARE total_horas_trabalhadas_projeto INT DEFAULT 0;

	SET total_horas_trabalhadas_projeto = COALESCE((SELECT (SELECT  sum(sp.carga_horaria)AS "total_horas_sup" FROM projetos p 
		inner join supervisor_projeto sp on p.id_supervisor_projeto  = sp.id
		WHERE sp.id_funcionario = id_projeto)
												+(SELECT  sum(fp.carga_horaria) AS "total_horas_trab" FROM funcionario_projeto fp 
														WHERE fp.id_projeto = id_projeto)),0) ;
													
	RETURN total_horas_trabalhadas_projeto;
	 
END;


CREATE PROCEDURE IF NOT EXISTS empresa.calculo_horas_realizada_projeto(IN _data JSON)
	BEGIN
			
		DECLARE id int DEFAULT 0;
		DECLARE total_horas_projeto float DEFAULT 0;
		DECLARE num_semanas_passadas float DEFAULT 0;
		DECLARE data_ultimo_calc date DEFAULT NULL;
		DECLARE horas_realizadas_atual float DEFAULT 0;
	
		SET id = json_unquote(json_extract(_data,'$.id'));
			
		SET total_horas_projeto = fn_total_horas_trabalhadas_projeto(id);
		SET data_ultimo_calc = (select p.data_ultima_medicao from projetos p where p.id = id);
		SET num_semanas_passadas = DATEDIFF(CURDATE(),data_ultimo_calc)/7;
		SET horas_realizadas_atual = (select p.total_horas_realizadas from projetos p where p.id = id);
		IF num_semanas_passadas > 0 THEN 
			UPDATE projetos p
			SET total_horas_realizadas = (num_semanas_passadas * total_horas_projeto), data_ultima_medicao = CURDATE(), updated_at = now()
			WHERE p.id = id;
		END IF; 
	 	
	END;



CREATE PROCEDURE IF NOT EXISTS empresa.prazo_estimado_projeto(IN _data JSON)
	BEGIN
			
		DECLARE id int DEFAULT 0;
		DECLARE total_horas float DEFAULT 0;		
		DECLARE horas_restantes_projeto float DEFAULT 0;
		DECLARE num_semanas_res FLOAT DEFAULT 0;
	
		SET id = json_unquote(json_extract(_data,'$.id'));			
		SET total_horas = fn_total_horas_trabalhadas_projeto(id);		
		SET horas_restantes_projeto = (select (p.total_horas_para_concluir  - p.total_horas_realizadas) from projetos p where p.id = id);
		SET num_semanas_res = COALESCE((horas_restantes_projeto/total_horas),0);
	
		IF horas_restantes_projeto > 0 AND num_semanas_res > 0 THEN 
			UPDATE projetos p
			SET data_prazo_estimado = (DATE_ADD(CURDATE(), INTERVAL (num_semanas_res * 7) DAY)), updated_at = now()
			WHERE p.id = id;
		END IF; 
	 	
	END;


