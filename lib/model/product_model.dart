
class ProductModel {
    String? id;
    String? nameEn;
    String? nameAr;
    int? capacity;
    bool? isDefault;
    bool? canBeDeleted;
    bool? canBeEdited;
    DateTime? createdOn;
    String? createdByName;
    String? lastModifiedByName;
    DateTime? lastModifiedOn;

    ProductModel({
        this.id,
        this.nameEn,
        this.nameAr,
        this.capacity,
        this.isDefault,
        this.canBeDeleted,
        this.canBeEdited,
        this.createdOn,
        this.createdByName,
        this.lastModifiedByName,
        this.lastModifiedOn,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        nameEn: json["nameEn"],
        nameAr: json["nameAr"],
        capacity: json["capacity"],
        isDefault: json["isDefault"],
        canBeDeleted: json["canBeDeleted"],
        canBeEdited: json["canBeEdited"],
        createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
        createdByName: json["createdByName"],
        lastModifiedByName: json["lastModifiedByName"],
        lastModifiedOn: json["lastModifiedOn"] == null ? null : DateTime.parse(json["lastModifiedOn"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nameEn": nameEn,
        "nameAr": nameAr,
        "capacity": capacity,
        "isDefault": isDefault,
        "canBeDeleted": canBeDeleted,
        "canBeEdited": canBeEdited,
        "createdOn": createdOn?.toIso8601String(),
        "createdByName": createdByName,
        "lastModifiedByName": lastModifiedByName,
        "lastModifiedOn": lastModifiedOn?.toIso8601String(),
    };
}
