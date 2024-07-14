CREATE TABLE employees
(
    id       INT AUTO_INCREMENT PRIMARY KEY,
    name     VARCHAR(100),
    position VARCHAR(100),
    details  JSON
);

INSERT INTO employees (name, position, details)
VALUES ('Alice', 'Software Engineer', '{
  "skills": [
    "Java",
    "JavaScript"
  ],
  "experience": 5,
  "certifications": [
    "AWS Certified Solutions Architect"
  ]
}'),
       ('Bob', 'Data Analyst', '{
         "skills": [
           "SQL",
           "Python"
         ],
         "experience": 3,
         "certifications": [
           "Microsoft Certified: Data Analyst Associate"
         ]
       }'),
       ('Carol', 'Project Manager', '{
         "skills": [
           "Leadership",
           "Agile"
         ],
         "experience": 7,
         "certifications": [
           "PMP",
           "CSM"
         ]
       }');

SELECT name, position, details->>'$.skills[0]' AS primary_skill FROM employees;


