class Employee {
  // final int eleft;
  // final String eadd;
  // final String epdate;
  final int id;
  final String name;
  final String jobTitle;
  final String workMobile;
  final String workEmail;
  final String deptName;
  final String managerName;
  final String pan;
  final String accno;
  final String joinDate;
  final String nationality;
  final String idNo;
  final String gender;
  final String maritalStatus;
  final double salaryInfo;

  Employee(
      // {required this.eleft,
      // required this.eadd,
      // required this.epdate,
      {required this.id,
      required this.name,
      required this.jobTitle,
      required this.workMobile,
      required this.workEmail,
      required this.deptName,
      required this.managerName,
      required this.pan,
      required this.accno,
      required this.joinDate,
      required this.nationality,
      required this.idNo,
      required this.gender,
      required this.maritalStatus,
      required this.salaryInfo});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
        // eadd: json['Address'],
        //eleft: json['leavesLeft'],
        //epdate: json['paySlipDue'],
        id: json['id'],
        name: json['name'],
        jobTitle: json['job_title '],
        workEmail: json['work_email'],
        workMobile: json['work_mobile'],
        deptName: json['department_name'],
        managerName: json['manager_name'],
        pan: json['pan'],
        accno: json['bank_acc_num'],
        joinDate: json['joining_date'],
        nationality: json['nationality'],
        idNo: json['identification_num'],
        gender: json['gender'],
        maritalStatus: json['marital_status'],
        salaryInfo: json['salary_info']);
  }
}

class Checkin {
  final String date;
  final String lat;
  final String lon;
  // final String _cad;

  Checkin({
    required this.date,
    required this.lat,
    required this.lon,
    // required this._cad,
  });
  factory Checkin.fromJson(Map<String, dynamic> json) {
    return Checkin(
      date: json['date'],
      lat: json['latitude_1'],
      lon: json['longitude_1'],
      // _cad: json['location_1'],
    );
  }
}
