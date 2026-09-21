

The database is designed to store user information, uploaded document metadata, AI tasks, chat conversations, and security audit records.

---

## Database Information

- **Database Name:** `sovereign`
- **Database System:** PostgreSQL
- **Schema:** `public`

---

## Database Tables

The database contains the following 6 tables:

1. `roles`
2. `users`
3. `documents`
4. `tasks`
5. `chat_history`
6. `audit_logs`

---

## Entity Relationship Diagram

![Database ER Diagram](docs/database-erd.png)

---

# 1. roles

The `roles` table stores the different roles available in the system.

| Column | Description |
|---|---|
| `role_id` | Unique ID of the role |
| `role_name` | Name of the role |

### Purpose

Used for role-based access control and user permissions.

---

# 2. users

The `users` table stores user account and authentication information.

| Column | Description |
|---|---|
| `user_id` | Unique user ID |
| `name` | User's name |
| `email` | Unique email address |
| `password_hash` | Hashed user password |
| `role_id` | References the user's role |
| `created_at` | Account creation timestamp |
| `is_active` | Indicates whether the account is active |

### Relationship

`roles → users`

One role can be assigned to multiple users.

---

# 3. documents

The `documents` table stores metadata about documents uploaded to the system.

| Column | Description |
|---|---|
| `document_id` | Unique document ID |
| `filename` | Name of the uploaded file |
| `file_type` | Type of document such as PDF, DOCX, or TXT |
| `storage_path` | Location/path of the stored document |
| `uploaded_by` | User who uploaded the document |
| `status` | Current document processing status |
| `created_at` | Document upload timestamp |

### Relationship

`users → documents`

One user can upload multiple documents.

---

# 4. tasks

The `tasks` table stores user requests and AI processing tasks.

| Column | Description |
|---|---|
| `task_id` | Unique task ID |
| `user_id` | User who created the task |
| `document_id` | Related document |
| `task_type` | Type of requested task |
| `request_text` | User's request or question |
| `status` | Current task status |
| `created_at` | Task creation timestamp |
| `completed_at` | Task completion timestamp |

### Relationships

`users → tasks`

`documents → tasks`

A user can create multiple tasks, and a document can be associated with multiple tasks.

---

# 5. chat_history

The `chat_history` table stores conversations between the user and the AI.

| Column | Description |
|---|---|
| `chat_id` | Unique chat message ID |
| `user_id` | User involved in the conversation |
| `task_id` | Related task |
| `message` | Actual message content |
| `sender` | Sender of the message, such as user or assistant |
| `created_at` | Message timestamp |

### Relationships

`users → chat_history`

`tasks → chat_history`

This allows each message to be connected to both the user and the related task.

---

# 6. audit_logs

The `audit_logs` table stores important system activities for security and accountability.

| Column | Description |
|---|---|
| `audit_id` | Unique audit record ID |
| `user_id` | User who performed the action |
| `action` | Action performed |
| `entity_type` | Type of affected entity |
| `entity_id` | ID of the affected entity |
| `details` | Additional information about the action |
| `created_at` | Time when the action occurred |

### Example Actions

- `LOGIN`
- `LOGOUT`
- `UPLOAD`
- `DOWNLOAD`
- `UPDATE`
- `DELETE`
- `APPROVE`

### Purpose

The audit log helps answer:

> **Who did what, to which entity, and when?**

This provides accountability and supports security monitoring.

---

# Database Relationships

```text
                         ROLES
                           │
                           │ 1 : N
                           ↓
                         USERS
                           │
             ┌─────────────┼─────────────┐
             │             │             │
           1 : N         1 : N         1 : N
             │             │             │
             ↓             ↓             ↓
        DOCUMENTS        TASKS       AUDIT_LOGS
                            │
                            │ 1 : N
                            ↓
                      CHAT_HISTORY
