  
  class UserResponse {
  final dynamic module;
  final String? id;
  final String? entity;
  final dynamic importKey;
  final ArrayOptions? arrayOptions;
  final dynamic arrayLanguages;
  final dynamic contactsIds;
  final dynamic linkedObjects;
  final dynamic linkedObjectsIds;
  final dynamic oldref;
  final dynamic actionmsg;
  final dynamic actionmsg2;
  final dynamic canvas;
  final dynamic fkProject;
  final dynamic contactId;
  final dynamic user;
  final dynamic origin;
  final dynamic originId;
  final dynamic originObject;
  final dynamic expedition;
  final dynamic livraison;
  final dynamic commandeFournisseur;
  final String? ref;
  final dynamic refExt;
  final String? statut;
  final String? status;
  final dynamic countryId;
  final String? countryCode;
  final dynamic stateId;
  final dynamic regionId;
  final dynamic barcodeType;
  final dynamic barcodeTypeCoder;
  final dynamic modeReglementId;
  final dynamic condReglementId;
  final dynamic demandReasonId;
  final dynamic transportModeId;
  final dynamic shippingMethod;
  final dynamic fkMulticurrency;
  final dynamic multicurrencyCode;
  final dynamic multicurrencyTx;
  final dynamic multicurrencyTotalHt;
  final dynamic multicurrencyTotalTva;
  final dynamic multicurrencyTotalTtc;
  final dynamic multicurrencyTotalLocaltax1;
  final dynamic multicurrencyTotalLocaltax2;
  final dynamic lastMainDoc;
  final dynamic fkBank;
  final dynamic fkAccount;
  final String? notePublic;
  final String? notePrivate;
  final dynamic name;
  final String? lastname;
  final String? firstname;
  final dynamic civilityId;
  final dynamic dateCreation;
  final dynamic dateValidation;
  final dynamic dateModification;
  final dynamic dateUpdate;
  final dynamic dateCloture;
  final dynamic userAuthor;
  final dynamic userCreation;
  final dynamic userCreationId;
  final dynamic userValid;
  final dynamic userValidation;
  final dynamic userValidationId;
  final dynamic userClosingId;
  final dynamic userModification;
  final dynamic userModificationId;
  final int? specimen;
  final dynamic totalpaid;
  final List<dynamic>? labelStatus;
  final List<dynamic>? labelStatusShort;
  final dynamic tpl;
  final dynamic showphotoOnPopup;
  final List<dynamic>? nb;
  final dynamic nbphoto;
  final dynamic output;
  final List<dynamic>? extraparams;
  final dynamic product;
  final dynamic condReglementSupplierId;
  final dynamic depositPercent;
  final dynamic retainedWarrantyFkCondReglement;
  final dynamic warehouseId;
  final String? employee;
  final String? civilityCode;
  final dynamic fullname;
  final dynamic gender;
  final String? birth;
  final String? email;
  final dynamic emailOauth2;
  final String? personalEmail;
  final List<dynamic>? socialnetworks;
  final String? job;
  final String? signature;
  final String? officePhone;
  final String? officeFax;
  final String? userMobile;
  final String? personalMobile;
  final String? admin;
  final String? login;
  final dynamic passCrypted;
  final int? datec;
  final int? datem;
  final dynamic socid;
  final dynamic fkMember;
  final dynamic fkUser;
  final dynamic fkUserExpenseValidator;
  final dynamic fkUserHolidayValidator;
  final dynamic clicktodialUrl;
  final dynamic clicktodialLogin;
  final dynamic clicktodialPoste;
  final int? datelastlogin;
  final int? datepreviouslogin;
  final int? flagdelsessionsbefore;
  final String? iplastlogin;
  final String? ippreviouslogin;
  final String? datestartvalidity;
  final String? dateendvalidity;
  final dynamic photo;
  final dynamic lang;
  final Rights? rights;
  final List<dynamic>? userGroupList;
  final Map<String, dynamic>? conf;
  final List<dynamic>? users;
  final dynamic parentof;
  final String? accountancyCode;
  final dynamic thm;
  final dynamic tjm;
  final dynamic salary;
  final dynamic salaryextra;
  final dynamic weeklyhours;
  final String? color;
  final String? dateemployment;
  final String? dateemploymentend;
  final dynamic defaultCExpTaxCat;
  final String? refEmployee;
  final String? nationalRegistrationNumber;
  final dynamic defaultRange;
  final dynamic fkWarehouse;
  final dynamic egroupwareId;
  final dynamic usergroupEntity;
  final String? address;
  final String? zip;
  final String? town;
  final dynamic url;

  UserResponse({
    required this.module,
    required this.id,
    required this.entity,
    required this.importKey,
    required this.arrayOptions,
    required this.arrayLanguages,
    required this.contactsIds,
    required this.linkedObjects,
    required this.linkedObjectsIds,
    required this.oldref,
    required this.actionmsg,
    required this.actionmsg2,
    required this.canvas,
    required this.fkProject,
    required this.contactId,
    required this.user,
    required this.origin,
    required this.originId,
    required this.originObject,
    required this.expedition,
    required this.livraison,
    required this.commandeFournisseur,
    required this.ref,
    required this.refExt,
    required this.statut,
    required this.status,
    required this.countryId,
    required this.countryCode,
    required this.stateId,
    required this.regionId,
    required this.barcodeType,
    required this.barcodeTypeCoder,
    required this.modeReglementId,
    required this.condReglementId,
    required this.demandReasonId,
    required this.transportModeId,
    required this.shippingMethod,
    required this.fkMulticurrency,
    required this.multicurrencyCode,
    required this.multicurrencyTx,
    required this.multicurrencyTotalHt,
    required this.multicurrencyTotalTva,
    required this.multicurrencyTotalTtc,
    required this.multicurrencyTotalLocaltax1,
    required this.multicurrencyTotalLocaltax2,
    required this.lastMainDoc,
    required this.fkBank,
    required this.fkAccount,
    required this.notePublic,
    required this.notePrivate,
    required this.name,
    required this.lastname,
    required this.firstname,
    required this.civilityId,
    required this.dateCreation,
    required this.dateValidation,
    required this.dateModification,
    required this.dateUpdate,
    required this.dateCloture,
    required this.userAuthor,
    required this.userCreation,
    required this.userCreationId,
    required this.userValid,
    required this.userValidation,
    required this.userValidationId,
    required this.userClosingId,
    required this.userModification,
    required this.userModificationId,
    required this.specimen,
    required this.totalpaid,
    required this.labelStatus,
    required this.labelStatusShort,
    required this.tpl,
    required this.showphotoOnPopup,
    required this.nb,
    required this.nbphoto,
    required this.output,
    required this.extraparams,
    required this.product,
    required this.condReglementSupplierId,
    required this.depositPercent,
    required this.retainedWarrantyFkCondReglement,
    required this.warehouseId,
    required this.employee,
    required this.civilityCode,
    required this.fullname,
    required this.gender,
    required this.birth,
    required this.email,
    required this.emailOauth2,
    required this.personalEmail,
    required this.socialnetworks,
    required this.job,
    required this.signature,
    required this.officePhone,
    required this.officeFax,
    required this.userMobile,
    required this.personalMobile,
    required this.admin,
    required this.login,
    required this.passCrypted,
    required this.datec,
    required this.datem,
    required this.socid,
    required this.fkMember,
    required this.fkUser,
    required this.fkUserExpenseValidator,
    required this.fkUserHolidayValidator,
    required this.clicktodialUrl,
    required this.clicktodialLogin,
    required this.clicktodialPoste,
    required this.datelastlogin,
    required this.datepreviouslogin,
    required this.flagdelsessionsbefore,
    required this.iplastlogin,
    required this.ippreviouslogin,
    required this.datestartvalidity,
    required this.dateendvalidity,
    required this.photo,
    required this.lang,
    required this.rights,
    required this.userGroupList,
    required this.conf,
    required this.users,
    required this.parentof,
    required this.accountancyCode,
    required this.thm,
    required this.tjm,
    required this.salary,
    required this.salaryextra,
    required this.weeklyhours,
    required this.color,
    required this.dateemployment,
    required this.dateemploymentend,
    required this.defaultCExpTaxCat,
    required this.refEmployee,
    required this.nationalRegistrationNumber,
    required this.defaultRange,
    required this.fkWarehouse,
    required this.egroupwareId,
    required this.usergroupEntity,
    required this.address,
    required this.zip,
    required this.town,
    required this.url,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      module: json['module'],
      id: json['id'] as String?,
      entity: json['entity'] as String?,
      importKey: json['import_key'],
      arrayOptions: json['array_options'] != null
          ? ArrayOptions.fromJson(json['array_options'])
          : null,
      arrayLanguages: json['array_languages'],
      contactsIds: json['contacts_ids'],
      linkedObjects: json['linked_objects'],
      linkedObjectsIds: json['linkedObjectsIds'],
      oldref: json['oldref'],
      actionmsg: json['actionmsg'],
      actionmsg2: json['actionmsg2'],
      canvas: json['canvas'],
      fkProject: json['fk_project'],
      contactId: json['contact_id'],
      user: json['user'],
      origin: json['origin'],
      originId: json['origin_id'],
      originObject: json['origin_object'],
      expedition: json['expedition'],
      livraison: json['livraison'],
      commandeFournisseur: json['commandeFournisseur'],
      ref: json['ref'] as String?,
      refExt: json['ref_ext'],
      statut: json['statut'] as String?,
      status: json['status'] as String?,
      countryId: json['country_id'],
      countryCode: json['country_code'] as String?,
      stateId: json['state_id'],
      regionId: json['region_id'],
      barcodeType: json['barcode_type'],
      barcodeTypeCoder: json['barcode_type_coder'],
      modeReglementId: json['mode_reglement_id'],
      condReglementId: json['cond_reglement_id'],
      demandReasonId: json['demand_reason_id'],
      transportModeId: json['transport_mode_id'],
      shippingMethod: json['shipping_method'],
      fkMulticurrency: json['fk_multicurrency'],
      multicurrencyCode: json['multicurrency_code'],
      multicurrencyTx: json['multicurrency_tx'],
      multicurrencyTotalHt: json['multicurrency_total_ht'],
      multicurrencyTotalTva: json['multicurrency_total_tva'],
      multicurrencyTotalTtc: json['multicurrency_total_ttc'],
      multicurrencyTotalLocaltax1: json['multicurrency_total_localtax1'],
      multicurrencyTotalLocaltax2: json['multicurrency_total_localtax2'],
      lastMainDoc: json['last_main_doc'],
      fkBank: json['fk_bank'],
      fkAccount: json['fk_account'],
      notePublic: json['note_public'] as String?,
      notePrivate: json['note_private'] as String?,
      name: json['name'],
      lastname: json['lastname'] as String?,
      firstname: json['firstname'] as String?,
      civilityId: json['civility_id'],
      dateCreation: json['date_creation'],
      dateValidation: json['date_validation'],
      dateModification: json['date_modification'],
      dateUpdate: json['date_update'],
      dateCloture: json['date_cloture'],
      userAuthor: json['user_author'],
      userCreation: json['user_creation'],
      userCreationId: json['user_creation_id'],
      userValid: json['user_valid'],
      userValidation: json['user_validation'],
      userValidationId: json['user_validation_id'],
      userClosingId: json['user_closing_id'],
      userModification: json['user_modification'],
      userModificationId: json['user_modification_id'],
      specimen: json['specimen'] as int?,
      totalpaid: json['totalpaid'],
      labelStatus: json['labelStatus'] as List<dynamic>?,
      labelStatusShort: json['labelStatusShort'] as List<dynamic>?,
      tpl: json['tpl'],
      showphotoOnPopup: json['showphoto_on_popup'],
      nb: json['nb'] as List<dynamic>?,
      nbphoto: json['nbphoto'],
      output: json['output'],
      extraparams: json['extraparams'] as List<dynamic>?,
      product: json['product'],
      condReglementSupplierId: json['cond_reglement_supplier_id'],
      depositPercent: json['deposit_percent'],
      retainedWarrantyFkCondReglement:
          json['retained_warranty_fk_cond_reglement'],
      warehouseId: json['warehouse_id'],
      employee: json['employee'] as String?,
      civilityCode: json['civility_code'] as String?,
      fullname: json['fullname'],
      gender: json['gender'],
      birth: json['birth'] as String?,
      email: json['email'] as String?,
      emailOauth2: json['email_oauth2'],
      personalEmail: json['personal_email'] as String?,
      socialnetworks: json['socialnetworks'] as List<dynamic>?,
      job: json['job'] as String?,
      signature: json['signature'] as String?,
      officePhone: json['office_phone'] as String?,
      officeFax: json['office_fax'] as String?,
      userMobile: json['user_mobile'] as String?,
      personalMobile: json['personal_mobile'] as String?,
      admin: json['admin'] as String?,
      login: json['login'] as String?,
      passCrypted: json['pass_crypted'],
      datec: json['datec'] as int?,
      datem: json['datem'] as int?,
      socid: json['socid'],
      fkMember: json['fk_member'],
      fkUser: json['fk_user'],
      fkUserExpenseValidator: json['fk_user_expense_validator'],
      fkUserHolidayValidator: json['fk_user_holiday_validator'],
      clicktodialUrl: json['clicktodial_url'],
      clicktodialLogin: json['clicktodial_login'],
      clicktodialPoste: json['clicktodial_poste'],
      datelastlogin: json['datelastlogin'] as int?,
      datepreviouslogin: json['datepreviouslogin'] as int?,
      flagdelsessionsbefore: json['flagdelsessionsbefore'] as int?,
      iplastlogin: json['iplastlogin'] as String?,
      ippreviouslogin: json['ippreviouslogin'] as String?,
      datestartvalidity: json['datestartvalidity'] as String?,
      dateendvalidity: json['dateendvalidity'] as String?,
      photo: json['photo'],
      lang: json['lang'],
      rights: json['rights'] != null
          ? Rights.fromJson(json['rights'])
          : null,
      userGroupList: json['user_group_list'] as List<dynamic>?,
      conf: json['conf'] as Map<String, dynamic>?,
      users: json['users'] as List<dynamic>?,
      parentof: json['parentof'],
      accountancyCode: json['accountancy_code'] as String?,
      thm: json['thm'],
      tjm: json['tjm'],
      salary: json['salary'],
      salaryextra: json['salaryextra'],
      weeklyhours: json['weeklyhours'],
      color: json['color'] as String?,
      dateemployment: json['dateemployment'] as String?,
      dateemploymentend: json['dateemploymentend'] as String?,
      defaultCExpTaxCat: json['default_c_exp_tax_cat'],
      refEmployee: json['ref_employee'] as String?,
      nationalRegistrationNumber: json['national_registration_number'] as String?,
      defaultRange: json['default_range'],
      fkWarehouse: json['fk_warehouse'],
      egroupwareId: json['egroupware_id'],
      usergroupEntity: json['usergroup_entity'],
      address: json['address'] as String?,
      zip: json['zip'] as String?,
      town: json['town'] as String?,
      url: json['url'],
    );
  }
}

class ArrayOptions {
  final String? optionsMeta;

  ArrayOptions({required this.optionsMeta});

  factory ArrayOptions.fromJson(Map<String, dynamic> json) {
    return ArrayOptions(
      optionsMeta: json['options_meta'] as String?,
    );
  }
}

class Rights {
  final Map<String, dynamic>? user;

  Rights({required this.user});

  factory Rights.fromJson(Map<String, dynamic> json) {
    return Rights(
      user: json['user'] as Map<String, dynamic>?,
    );
  }
}
