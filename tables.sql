CREATE TABLE Students(
    idnr REAL,
    name TEXT NOT NULL,
    login TEXT NOT NULL,
    program TEXT NOT NULL,
    PRIMARY KEY (idnr)
);
CREATE TABLE Branches(
    name TEXT,
    program TEXT,
    PRIMARY KEY(name, program)
);
CREATE TABLE Courses(
    code CHAR(6),
    name TEXT NOT NULL,
    credits INT NOT NULL,
    department TEXT NOT NULL,
    PRIMARY KEY(code)
);
CREATE TABLE LimitedCourses(
    code CHAR(6) REFERENCES Courses(code),
    capacity INT NOT NULL,
    PRIMARY KEY (code) 
);
CREATE TABLE StudentBranches(
    student REAL REFERENCES Students(idnr),
    branch TEXT NOT NULL,
    program TEXT NOT NULL,
    PRIMARY KEY (student),
    FOREIGN KEY (branch, program) REFERENCES Branches(name, program)
);
CREATE TABLE Classifications(
    name TEXT,
    PRIMARY KEY (name)
);
CREATE TABLE Classified(
    course CHAR(6) REFERENCES Courses(code),
    classification TEXT REFERENCES Classifications(name),
    PRIMARY KEY(course, classification)
);
CREATE TABLE MandatoryProgram(
    course CHAR(6) REFERENCES Courses(code),
    program TEXT,
    PRIMARY KEY(course, program)
);
CREATE TABLE MandatoryBranch(
    course CHAR(6) REFERENCES Courses(code),
    branch TEXT,
    program TEXT,
    PRIMARY KEY(course, branch, program),
    FOREIGN KEY (branch, program) REFERENCES Branches(name, program)
);
CREATE TABLE RecommendedBranch(
 course CHAR(6),
 branch TEXT,
 program TEXT,
 FOREIGN KEY (course) REFERENCES Courses(code),
 FOREIGN KEY (branch, program) REFERENCES Branches(name,program),
 PRIMARY KEY(course,branch,program)
);
CREATE TABLE Registered(
    student REAL REFERENCES Students(idnr),
    course CHAR(6) REFERENCES Courses(code),
    PRIMARY KEY (student, course)
);
CREATE TABLE Taken(
student REAL, 
course CHAR(6),
grade TEXT,
PRIMARY KEY(student, course),
FOREIGN KEY (student) REFERENCES Students(idnr),
FOREIGN KEY (course) REFERENCES Courses(code),
CHECK (grade IN ('U', '3', '4', '5'))
);
CREATE TABLE WaitingList(
    student REAL REFERENCES Students(idnr),
    course CHAR(6) REFERENCES LimitedCourses(code),
    position INT NOT NULL,
    PRIMARY KEY(student, course)

);
