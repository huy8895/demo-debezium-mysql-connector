CREATE TABLE employees
(
    id       INT AUTO_INCREMENT PRIMARY KEY,
    name     VARCHAR(100),
    position VARCHAR(100),
    details  JSON
);

INSERT INTO employees (name, position, details) VALUES
                                                    ('Alice', 'Software Engineer', '{"skills": ["Java", "JavaScript"], "experience": 5, "certifications": ["AWS Certified Solutions Architect"]}'),
                                                    ('Bob', 'Data Analyst', '{"skills": ["SQL", "Python"], "experience": 3, "certifications": ["Microsoft Certified: Data Analyst Associate"]}'),
                                                    ('Carol', 'Project Manager', '{"skills": ["Leadership", "Agile"], "experience": 7, "certifications": ["PMP", "CSM"]}'),
                                                    ('David', 'System Administrator', '{"skills": ["Linux", "Networking"], "experience": 4, "certifications": ["RHCE", "CCNA"]}'),
                                                    ('Eve', 'DevOps Engineer', '{"skills": ["Docker", "Kubernetes"], "experience": 6, "certifications": ["CKA", "AWS Certified DevOps Engineer"]}'),
                                                    ('Frank', 'Database Administrator', '{"skills": ["MySQL", "PostgreSQL"], "experience": 8, "certifications": ["Oracle Certified Professional"]}'),
                                                    ('Grace', 'UI/UX Designer', '{"skills": ["Sketch", "Figma"], "experience": 2, "certifications": ["Adobe Certified Expert"]}'),
                                                    ('Hank', 'Cybersecurity Specialist', '{"skills": ["Penetration Testing", "SIEM"], "experience": 5, "certifications": ["CEH", "CISSP"]}'),
                                                    ('Ivy', 'Machine Learning Engineer', '{"skills": ["TensorFlow", "PyTorch"], "experience": 4, "certifications": ["Google Professional Machine Learning Engineer"]}'),
                                                    ('Jack', 'Cloud Architect', '{"skills": ["AWS", "Azure"], "experience": 9, "certifications": ["AWS Certified Solutions Architect", "Azure Solutions Architect Expert"]}');

SELECT name, position, details->>'$.skills[0]' AS primary_skill FROM employees;


