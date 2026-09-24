/*Listado de inscripciones aprobadas */
select students.id, courses.title, enrollments.completion_percentage
from
    enrollments
    inner join students on enrollments.student_id = students.id
    inner join courses on enrollments.course_id = courses.id
where
    enrollments.passed = true

/* Listado de estudiantes con al menos un cursos aprobados */

select students.name, students.email, courses.title
from
    enrollments
    inner join students on enrollments.student_id = students.id
    inner join courses on enrollments.course_id = courses.id
where
    enrollments.passed = true

/* Porcentaje de completado medio por instructor*/

select courses.instructor_name, avg(
        enrollments.completion_percentage
    ) as Promedio_completado
from enrollments
    inner join courses on enrollments.course_id = courses.id
group by
    courses.instructor_name
order by Promedio_completado desc

/* Listado de estudiantes sin inscipciones */
select students.name, students.email
from students
    left join enrollments on students.id = enrollments.student_id
where
    enrollments.id is null;

/* Listado de cursos sin inscripciones */
select courses.title
from courses
    left join enrollments on courses.id = enrollments.course_id
where
    enrollments.id is null;

/* Cantidad de cursos de cada estudiante con mas de un curso */
select students.name, count(enrollments.course_id) as cantidad_cursos
from students
    inner join enrollments on students.id = enrollments.student_id
group by
    students.name
having
    count(enrollments.course_id) > 1;

/* Ingresos totales por categoria */
select courses.category, sum(courses.monthly_fee) as ingresos_totales
from courses
    inner join enrollments on courses.id = enrollments.course_id
group by
    courses.category;

/* Listado de instructores con el numero de estudiantes inscritos en sus cursos */
select courses.instructor_name, count(
        distinct enrollments.student_id
    ) as numero_estudiantes
from courses
    inner join enrollments on courses.id = enrollments.course_id
group by
    courses.instructor_name
order by numero_estudiantes desc;

/* Comprobar si inscripciones no corresponden a ningun estudiante existente */
select enrollments.id, enrollments.student_id, enrollments.course_id
from enrollments
    left join students on enrollments.student_id = students.id
where
    students.id is null;

/* Comprobar si inscripciones no corresponden a ningun curso existente */
select enrollments.id, enrollments.student_id, enrollments.course_id
from enrollments
    left join courses on enrollments.course_id = courses.id
where
    courses.id is null;