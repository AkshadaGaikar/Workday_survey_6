 view: Emp_Survey {
   # Or, you could make this view a derived table, like this:
   derived_table: {
     sql: select EmpDetails.EmployeeID as EmployeeID,
        EmpDetails.ManagerID as ManagerID,
        EmpDetails.Designation as Designation,
        Survey.Question as Question,
        Survey.SurveyName as SurveyName,
        Survey.Response as Response,
        case when  EmpDetails.Designation='CEO' then 2
            When EmpDetails.Designation='HR' then 2
            When EmpDetails.Designation='Manager' and (select count(*) from `sab-dev-proj-dev-dw-4905.WORKDAY_SURVEY.manager_emp_hier5` as EMP where EMP.ManagerID=EmpDetails.EmployeeID)>2 then 2
            else 1
        end  as NumberOfEmp
 from `sab-dev-proj-dev-dw-4905.WORKDAY_SURVEY.manager_emp_hier5` as EmpDetails
left join `sab-dev-proj-dev-dw-4905.WORKDAY_SURVEY.Survey5` as Survey on EmpDetails.EmployeeID=Survey.EmployeeID
      ;;
   }
#
#   # Define your dimensions and measures here, like this:
  dimension: EmployeeID {
    description: "EmployeeID"
    type: string
    sql: ${TABLE}.EmployeeID ;;
  }

  dimension: ManagerID {
    description: "ManagerID"
    type: string
    sql: ${TABLE}.ManagerID ;;
  }

  dimension: Designation {
    description: "Designation"
    type: string
    sql: ${TABLE}.Designation ;;
  }
  dimension: SurveyName {
    description: "SurveyName"
    type: string
    sql: ${TABLE}.SurveyName ;;
  }

  dimension: Question {
    description: "Question"
    type: string
    sql: ${TABLE}.Question ;;
  }

  dimension: Response {
    description: "Question"
    type: string
    sql: ${TABLE}.Response ;;
  }

  dimension: NumberOfEmp {
    description: "Question"
    type: number
    sql: ${TABLE}.NumberOfEmp ;;
  }

 measure: count {
  type: count
 # drill_fields: [SurveyName]
}
 }
