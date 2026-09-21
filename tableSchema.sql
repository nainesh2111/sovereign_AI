CREATE TABLE roles(
	role_id SERIAL PRIMARY KEY,
	role_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE users(
	user_id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	email VARCHAR(150) UNIQUE NOT NULL,
	password_hash TEXT NOT NULL,
	role_id INT REFERENCES roles(role_id),
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE documents(
	document_id SERIAL PRIMARY KEY,
	filename VARCHAR(250) NOT NULL,
	file_type VARCHAR(50) NOT NULL,
	storage_path TEXT,
	uploaded_by INT REFERENCES users(user_id),
	status VARCHAR(50) DEFAULT 'uploaded',
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tasks(
	task_id SERIAL PRIMARY KEY,
	user_id INT REFERENCES users(user_id),
	document_id INT REFERENCES documents(document_id),
	task_type VARCHAR(100),
	request_text TEXT,
	status VARCHAR(50) DEFAULT 'pending',
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	complated_at TIMESTAMP
);

CREATE TABLE chat_history(
	chat_id SERIAL PRIMARY KEY,
	user_id INT REFERENCES users(user_id),
	task_id INT REFERENCES tasks(task_id),
	message TEXT NOT NULL,
	sender VARCHAR(20) NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE audit_logs (
    audit_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    action VARCHAR(100) NOT NULL,
    entity_type VARCHAR(100),
    entity_id INT,
    details TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
