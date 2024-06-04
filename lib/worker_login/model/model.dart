import 'dart:convert';

Workers workersFromJson(String str) => Workers.fromJson(json.decode(str));

String workersToJson(Workers data) => json.encode(data.toJson());

class Workers {
  DashboardDetails dashboardDetails;

  Workers({
    required this.dashboardDetails,
  });

  factory Workers.fromJson(Map<String, dynamic> json) => Workers(
        dashboardDetails: DashboardDetails.fromJson(json["dashboard_details"]),
      );

  Map<String, dynamic> toJson() => {
        "dashboard_details": dashboardDetails.toJson(),
      };
}

class DashboardDetails {
  int openPreventive;
  int assignedPreventive;
  int completedPreventive;
  int openCorrective;
  int assignedCorrective;
  int verifiedCorrective;
  int completedCorrective;
  List<RecentWorkordersPreventive> recentWorkordersPreventive;
  List<RecentWorkordersCorrective> recentWorkordersCorrective;
  List<RecentWorkordersPreventive> workordersAssigned;

  DashboardDetails({
    required this.openPreventive,
    required this.assignedPreventive,
    required this.completedPreventive,
    required this.openCorrective,
    required this.assignedCorrective,
    required this.verifiedCorrective,
    required this.completedCorrective,
    required this.recentWorkordersPreventive,
    required this.recentWorkordersCorrective,
    required this.workordersAssigned,
  });

  factory DashboardDetails.fromJson(Map<String, dynamic> json) =>
      DashboardDetails(
        openPreventive: json["open_preventive"] ?? 0,
        assignedPreventive: json["assigned_preventive"] ?? 0,
        completedPreventive: json["completed_preventive"] ?? 0,
        openCorrective: json["open_corrective"] ?? 0,
        assignedCorrective: json["assigned_corrective"] ?? 0,
        verifiedCorrective: json["verified_corrective"] ?? 0,
        completedCorrective: json["completed_corrective"] ?? 0,
        recentWorkordersPreventive: json["recent_workorders_preventive"] == null
            ? []
            : List<RecentWorkordersPreventive>.from(
                json["recent_workorders_preventive"]
                    .map((x) => RecentWorkordersPreventive.fromJson(x))),
        recentWorkordersCorrective: json["recent_workorders_corrective"] == null
            ? []
            : List<RecentWorkordersCorrective>.from(
                json["recent_workorders_corrective"]
                    .map((x) => RecentWorkordersCorrective.fromJson(x))),
        workordersAssigned: json["workorders_assigned"] == null
            ? []
            : List<RecentWorkordersPreventive>.from(json["workorders_assigned"]
                .map((x) => RecentWorkordersPreventive.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "open_preventive": openPreventive,
        "assigned_preventive": assignedPreventive,
        "completed_preventive": completedPreventive,
        "open_corrective": openCorrective,
        "assigned_corrective": assignedCorrective,
        "verified_corrective": verifiedCorrective,
        "completed_corrective": completedCorrective,
        "recent_workorders_preventive": List<dynamic>.from(
            recentWorkordersPreventive.map((x) => x.toJson())),
        "recent_workorders_corrective": List<dynamic>.from(
            recentWorkordersCorrective.map((x) => x.toJson())),
        "workorders_assigned":
            List<dynamic>.from(workordersAssigned.map((x) => x.toJson())),
      };
}

class RecentWorkordersCorrective {
  int id;
  String woName;
  String description;
  int woTypeId;
  int entryById;
  int siteId;
  dynamic locationId;
  int assetId;
  dynamic folderId;
  int billable;
  DateTime scheduleFirstDate;
  int crewSize;
  int estimatedManpowerHour;
  Priority priority;
  RecentWorkordersCorrectiveStatus status;
  String? instructions;
  String safetyMeasures;
  dynamic shopCode;
  int? scheduleNum;
  ScheduleType? scheduleType;
  RecordType recordType;
  dynamic comments;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;
  DateTime lastGeneratedAt;

  RecentWorkordersCorrective({
    required this.id,
    required this.woName,
    required this.description,
    required this.woTypeId,
    required this.entryById,
    required this.siteId,
    required this.locationId,
    required this.assetId,
    required this.folderId,
    required this.billable,
    required this.scheduleFirstDate,
    required this.crewSize,
    required this.estimatedManpowerHour,
    required this.priority,
    required this.status,
    this.instructions,
    required this.safetyMeasures,
    this.shopCode,
    this.scheduleNum,
    this.scheduleType,
    required this.recordType,
    this.comments,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.lastGeneratedAt,
  });

  factory RecentWorkordersCorrective.fromJson(Map<String, dynamic> json) =>
      RecentWorkordersCorrective(
        id: json["id"],
        woName: json["wo_name"] ?? 'Unknown Workorder',
        description: json["description"] ?? 'No description available',
        woTypeId: json["wo_type_id"],
        entryById: json["entry_by_id"],
        siteId: json["site_id"],
        locationId: json["location_id"],
        assetId: json["asset_id"],
        folderId: json["folder_id"],
        billable: json["billable"],
        scheduleFirstDate: DateTime.parse(json["schedule_first_date"]),
        crewSize: json["crew_size"],
        estimatedManpowerHour: json["estimated_manpower_hour"],
        priority: priorityValues.map[json["priority"]]!,
        status: recentWorkordersCorrectiveStatusValues.map[json["status"]]!,
        instructions: json["instructions"],
        safetyMeasures: json["safety_measures"] ?? '',
        shopCode: json["shop_code"],
        scheduleNum: json["schedule_num"],
        scheduleType: scheduleTypeValues.map[json["schedule_type"]],
        recordType: recordTypeValues.map[json["record_type"]]!,
        comments: json["comments"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] == null
            ? null
            : DateTime.parse(json["deleted_at"]),
        lastGeneratedAt: DateTime.parse(json["last_generated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "wo_name": woName,
        "description": description,
        "wo_type_id": woTypeId,
        "entry_by_id": entryById,
        "site_id": siteId,
        "location_id": locationId,
        "asset_id": assetId,
        "folder_id": folderId,
        "billable": billable,
        "schedule_first_date":
            "${scheduleFirstDate.year.toString().padLeft(4, '0')}-${scheduleFirstDate.month.toString().padLeft(2, '0')}-${scheduleFirstDate.day.toString().padLeft(2, '0')}",
        "crew_size": crewSize,
        "estimated_manpower_hour": estimatedManpowerHour,
        "priority": priorityValues.reverse[priority],
        "status": recentWorkordersCorrectiveStatusValues.reverse[status],
        "instructions": instructions,
        "safety_measures": safetyMeasures,
        "shop_code": shopCode,
        "schedule_num": scheduleNum,
        "schedule_type": scheduleTypeValues.reverse[scheduleType],
        "record_type": recordTypeValues.reverse[recordType],
        "comments": comments,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt?.toIso8601String(),
        "last_generated_at": lastGeneratedAt.toIso8601String(),
      };
}

enum Priority { P1_URGENT, P2_NORMAL }

final priorityValues = EnumValues(
    {"P1: Urgent": Priority.P1_URGENT, "P2: Normal": Priority.P2_NORMAL});

enum RecordType { REQUEST, TEMPLATE }

final recordTypeValues = EnumValues(
    {"REQUEST": RecordType.REQUEST, "TEMPLATE": RecordType.TEMPLATE});

enum ScheduleType { MONTH, WEEK }

final scheduleTypeValues =
    EnumValues({"MONTH": ScheduleType.MONTH, "WEEK": ScheduleType.WEEK});

enum RecentWorkordersCorrectiveStatus { OPEN }

final recentWorkordersCorrectiveStatusValues =
    EnumValues({"OPEN": RecentWorkordersCorrectiveStatus.OPEN});

class RecentWorkordersPreventive {
  int id;
  int woTemplateId;
  dynamic scheduledById; 
  int? assignedToId;
  int? assignedById;
  DateTime scheduledStartDate;
  dynamic scheduledFinishDate;
  DateTime? actualStartDate;
  DateTime? actualFinishDate;
  DateTime? closedDate;
  int? closedBy;
  RecentWorkordersPreventiveStatus status;
  Priority priority;
  String? comments;
  DateTime createdAt;
  DateTime updatedAt;
  RecentWorkordersCorrective? template;

  RecentWorkordersPreventive({
    required this.id,
    required this.woTemplateId,
    this.scheduledById,
    this.assignedToId,
    this.assignedById,
    required this.scheduledStartDate,
    this.scheduledFinishDate,
    this.actualStartDate,
    this.actualFinishDate,
    this.closedDate,
    this.closedBy,
    required this.status,
    required this.priority,
    this.comments,
    required this.createdAt,
    required this.updatedAt,
    this.template,
  });

  factory RecentWorkordersPreventive.fromJson(Map<String, dynamic> json) =>
      RecentWorkordersPreventive(
        id: json["id"],
        woTemplateId: json["wo_template_id"],
        scheduledById: json["scheduled_by_id"],
        assignedToId: json["assigned_to_id"],
        assignedById: json["assigned_by_id"],
        scheduledStartDate: DateTime.parse(json["scheduled_start_date"]),
        scheduledFinishDate: json["scheduled_finish_date"],
        actualStartDate: json["actual_start_date"] == null
            ? null
            : DateTime.parse(json["actual_start_date"]),
        actualFinishDate: json["actual_finish_date"] == null
            ? null
            : DateTime.parse(json["actual_finish_date"]),
        closedDate: json["closed_date"] == null
            ? null
            : DateTime.parse(json["closed_date"]),
        closedBy: json["closed_by"],
        status: recentWorkordersPreventiveStatusValues.map[json["status"]]!,
        priority: priorityValues.map[json["priority"]]!,
        comments: json["comments"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        template: json["template"] == null
            ? null
            : RecentWorkordersCorrective.fromJson(json["template"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "wo_template_id": woTemplateId,
        "scheduled_by_id": scheduledById,
        "assigned_to_id": assignedToId,
        "assigned_by_id": assignedById,
        "scheduled_start_date": scheduledStartDate.toIso8601String(),
        "scheduled_finish_date": scheduledFinishDate,
        "actual_start_date": actualStartDate?.toIso8601String(),
        "actual_finish_date": actualFinishDate?.toIso8601String(),
        "closed_date": closedDate?.toIso8601String(),
        "closed_by": closedBy,
        "status": recentWorkordersPreventiveStatusValues.reverse[status],
        "priority": priorityValues.reverse[priority],
        "comments": comments,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "template": template?.toJson(),
      };
}

enum RecentWorkordersPreventiveStatus { CLOSED, SCHEDULED }

final recentWorkordersPreventiveStatusValues = EnumValues({
  "CLOSED": RecentWorkordersPreventiveStatus.CLOSED,
  "SCHEDULED": RecentWorkordersPreventiveStatus.SCHEDULED
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
