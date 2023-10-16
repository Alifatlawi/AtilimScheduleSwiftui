//
//  BusinessModel.swift
//  AtilimSchedule
//
//  Created by Ali Amer on 10/16/23.
//
import Foundation

enum BusinessModel {
    // MARK: - Welcome
    struct Welcome: Codable {
        let r: R
        let ce: Ce
    }

    // MARK: - Ce
    struct Ce: Codable {
        let ttdocs: Int
    }

    // MARK: - R
    struct R: Codable {
        let rights: [String: Bool]
        let dbiAccessorRes: DbiAccessorRes
        let changeEvents: ChangeEvents

        enum CodingKeys: String, CodingKey {
            case rights, dbiAccessorRes
            case changeEvents = "_changeEvents"
        }
    }

    // MARK: - ChangeEvents
    struct ChangeEvents: Codable {
        let dbiGlobalSettings: Int

        enum CodingKeys: String, CodingKey {
            case dbiGlobalSettings = "dbi:global_settings"
        }
    }

    // MARK: - DbiAccessorRes
    struct DbiAccessorRes: Codable {
        let type, dbid: String
        let tables: [Table]
        let changeEvents: ChangeEventsClass
    }

    // MARK: - ChangeEventsClass
    struct ChangeEventsClass: Codable {
    }

    // MARK: - Table
    struct Table: Codable {
        let id: String
        let def: Def
        let cdefs: [Cdef]
        let dataRows: [DataRow]
        let dataColumns: [String]

        enum CodingKeys: String, CodingKey {
            case id, def, cdefs
            case dataRows = "data_rows"
            case dataColumns = "data_columns"
        }
    }

    // MARK: - Cdef
    struct Cdef: Codable {
        let id: String
        let type: String?
        let name: String
        let subcolumns: [Subcolumn]?
        let table: String?
    }

    // MARK: - Subcolumn
    struct Subcolumn: Codable {
        let id: String
        let type: TypeEnum
        let name: String
        let subcolumns: [Subcolumn]?
    }

    enum TypeEnum: String, Codable {
        case booleanOrNull = "boolean_or_null"
        case checkbox = "checkbox"
        case combo = "combo"
        case float = "float"
        case int = "int"
        case intcombo = "intcombo"
        case string = "string"
        case subdata = "subdata"
        case subobject = "subobject"
        case time = "time"
    }

    // MARK: - DataRow
    struct DataRow: Codable {
        let id: String
        let name: String?
        let settings: Settings?
        let year: Int?
        let regName, period, short, starttime: String?
        let endtime: String?
        let daydata: ChangeEventsClass?
        let printinsummary, printinteacher, printinclass, printinclassroom: Bool?
        let printonlyinbells: [JSONAny]?
        let bell: String?
        let perioddata, breakdata: ChangeEventsClass?
        let typ: TypUnion?
        let vals: [String]?
        let val: Int?
        let buildingid: String?
        let sharedroom, needssupervision: Bool?
        let color: String?
        let nearbyclassroomids: [JSONAny]?
        let teacherid: String?
        let classroomids: [String]?
        let timeoff: [[[String]]]?
        let printsubjectpictures: Bool?
        let classroomid, pictureURL: String?
        let contractWeight: Int?
        let gender, fontcolorprint, fontcolorprint2, fontcolorscreen: String?
        let classid: String?
        let entireclass: Bool?
        let ascttdivision: String?
        let okgroup: Bool?
        let studentsCount: JSONNull?
        let divisionid: String?
        let groupids: [String]?
        let subjectid: String?
        let teacherids, classids: [String]?
        let count, durationperiods: Int?
        let classroomidss: [[String]]?
        let termsdefid, weeksdefid: Sdefid?
        let daysdefid: Daysdefid?
        let terms: String?
        let seminargroup: JSONNull?
        let studentids: [JSONAny]?
        let groupnames: [String]?
        let lessonid: String?
        let locked: Bool?
        let days, weeks: String?
        let fitwidth, fitheight, hideemptycolumns, hideemptyrows: Bool?
        let headerwidth, headerheight, cellwidth, cellheight: Double?
        let pageTables, rowTables: [String]?
        let columnTables: [ColumnTable]?
        let celltype: Int?
        let cardcolorenabled: Bool?
        let cardcolortable1, cardcolortable2: String?
        let cardcolorpos: Cardcolorpos?
        let cardstyles: [Cardstyle]?
        let classroomsupervisionstyle: Classroomsupervisionstyle?
        let gridheadertexts: Gridheadertexts?
        let pageheader: Classroomsupervisionstyle?
        let pageheaderprefixenabled: Bool?
        let userheader: Classroomsupervisionstyle?
        let landscape: Bool?
        let repeatpage, splitpageH, splitpageW: Int?
        let withclassroomtt, printlogo: Bool?
        let extracolumns, extrarows: [Extra]?

        enum CodingKeys: String, CodingKey {
            case id, name, settings, year
            case regName = "reg_name"
            case period, short, starttime, endtime, daydata, printinsummary, printinteacher, printinclass, printinclassroom, printonlyinbells, bell, perioddata, breakdata, typ, vals, val, buildingid, sharedroom, needssupervision, color, nearbyclassroomids, teacherid, classroomids, timeoff, printsubjectpictures, classroomid
            case pictureURL = "picture_url"
            case contractWeight = "contract_weight"
            case gender, fontcolorprint, fontcolorprint2, fontcolorscreen, classid, entireclass, ascttdivision, okgroup
            case studentsCount = "students_count"
            case divisionid, groupids, subjectid, teacherids, classids, count, durationperiods, classroomidss, termsdefid, weeksdefid, daysdefid, terms, seminargroup, studentids, groupnames, lessonid, locked, days, weeks, fitwidth, fitheight, hideemptycolumns, hideemptyrows, headerwidth, headerheight, cellwidth, cellheight
            case pageTables = "page_tables"
            case rowTables = "row_tables"
            case columnTables = "column_tables"
            case celltype, cardcolorenabled, cardcolortable1, cardcolortable2, cardcolorpos, cardstyles, classroomsupervisionstyle, gridheadertexts, pageheader, pageheaderprefixenabled, userheader, landscape, repeatpage
            case splitpageH = "splitpage_h"
            case splitpageW = "splitpage_w"
            case withclassroomtt, printlogo, extracolumns, extrarows
        }
    }

    enum Cardcolorpos: String, Codable {
        case cardcolorposLeft = "left"
        case empty = ""
    }

    // MARK: - Cardstyle
    struct Cardstyle: Codable {
        let texts: Texts
        let mNDlzka, mNPocetRiadkov, mNBezTriedyAleboUcitela: Int

        enum CodingKeys: String, CodingKey {
            case texts
            case mNDlzka = "m_nDlzka"
            case mNPocetRiadkov = "m_nPocetRiadkov"
            case mNBezTriedyAleboUcitela = "m_nBezTriedyAleboUcitela"
        }
    }

    // MARK: - Texts
    struct Texts: Codable {
        let subjects, teachers, classrooms, groupnames: Days
        let classes, count, time: Days
    }

    // MARK: - Days
    struct Days: Codable {
        let enabled: Bool?
        let pos: Int?
        let size: Double
        let font: Font
        let bold, italic, underline: Bool
        let autohide: Bool?
        let nameCol: String?
        let column: Column?

        enum CodingKeys: String, CodingKey {
            case enabled, pos, size, font, bold, italic, underline, autohide
            case nameCol = "name_col"
            case column
        }
    }

    enum Column: String, Codable {
        case empty = ""
        case name = "name"
        case short = "short"
        case the2Lines = "2lines"
    }

    enum Font: String, Codable {
        case arial = "Arial"
        case timesNewRoman = "Times New Roman"
    }

    // MARK: - Classroomsupervisionstyle
    struct Classroomsupervisionstyle: Codable {
        let size: Double
        let font: Font
        let bold, italic, underline: Bool
        let vertical: Bool?
        let text: String?
    }

    enum ColumnTable: String, Codable {
        case days = "days"
        case periods = "periods"
        case subjects = "subjects"
    }

    enum Daysdefid: String, Codable {
        case the6 = "*6"
    }

    // MARK: - Extra
    struct Extra: Codable {
        let name: String
        let size: Int
        let headerstyle, cellstyle: Classroomsupervisionstyle
        let typ: String
    }

    // MARK: - Gridheadertexts
    struct Gridheadertexts: Codable {
        let days, periods, time, objects: Days
    }

    // MARK: - Settings
    struct Settings: Codable {
        let mNZlozitostGener: Int?
        let mBAllowZlavnenie, mBGenerDraft: Bool?
        let mNCoGenerovat, mNSchoolType, mNGapsCounting: Int?
        let mBSujectsInMinutes: Bool?
        let nameFormat, mStrPrintHeaderText, mStrDateBellowTimeTable: String?
        let mBPrintDozory, mBPrintDozoryVSuhrnnych, mBPrintDozoryColor, mBPrintSinglesSpolu: Bool?
        let mBPrintDoublesAsSingles: Bool?
        let mNTimeFormat, mNPrvyDen: Int?
        let mBPrintDayAsNumber: Bool?
        let mDozoryKriteria: [String: Int]?
        let draftOptions: ChangeEventsClass?
        let mNSirkaCiaryLesson, mNSirkaCiaryOkraj, mNSirkaCiaryDen: Int?

        enum CodingKeys: String, CodingKey {
            case mNZlozitostGener = "m_nZlozitostGener"
            case mBAllowZlavnenie = "m_bAllowZlavnenie"
            case mBGenerDraft = "m_bGenerDraft"
            case mNCoGenerovat = "m_nCoGenerovat"
            case mNSchoolType = "m_nSchoolType"
            case mNGapsCounting = "m_nGapsCounting"
            case mBSujectsInMinutes = "m_bSujectsInMinutes"
            case nameFormat = "name_format"
            case mStrPrintHeaderText = "m_strPrintHeaderText"
            case mStrDateBellowTimeTable = "m_strDateBellowTimeTable"
            case mBPrintDozory = "m_bPrintDozory"
            case mBPrintDozoryVSuhrnnych = "m_bPrintDozoryVSuhrnnych"
            case mBPrintDozoryColor = "m_bPrintDozoryColor"
            case mBPrintSinglesSpolu = "m_bPrintSinglesSpolu"
            case mBPrintDoublesAsSingles = "m_bPrintDoublesAsSingles"
            case mNTimeFormat = "m_nTimeFormat"
            case mNPrvyDen = "m_nPrvyDen"
            case mBPrintDayAsNumber = "m_bPrintDayAsNumber"
            case mDozoryKriteria = "m_DozoryKriteria"
            case draftOptions = "draft_options"
            case mNSirkaCiaryLesson = "m_nSirkaCiaryLesson"
            case mNSirkaCiaryOkraj = "m_nSirkaCiaryOkraj"
            case mNSirkaCiaryDen = "m_nSirkaCiaryDen"
        }
    }

    enum Sdefid: String, Codable {
        case the3 = "*3"
    }

    enum TypUnion: Codable {
        case enumeration(TypEnum)
        case integer(Int)

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode(Int.self) {
                self = .integer(x)
                return
            }
            if let x = try? container.decode(TypEnum.self) {
                self = .enumeration(x)
                return
            }
            throw DecodingError.typeMismatch(TypUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for TypUnion"))
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .enumeration(let x):
                try container.encode(x)
            case .integer(let x):
                try container.encode(x)
            }
        }
    }

    enum TypEnum: String, Codable {
        case all = "all"
        case any = "any"
        case one = "one"
    }

    // MARK: - Def
    struct Def: Codable {
        let id, name, itemName, icon: String

        enum CodingKeys: String, CodingKey {
            case id, name
            case itemName = "item_name"
            case icon
        }
    }

    // MARK: - Encode/decode helpers

    class JSONNull: Codable, Hashable {

        public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(0)
        }


        public init() {}

        public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
    }

    class JSONCodingKey: CodingKey {
        let key: String

        required init?(intValue: Int) {
            return nil
        }

        required init?(stringValue: String) {
            key = stringValue
        }

        var intValue: Int? {
            return nil
        }

        var stringValue: String {
            return key
        }
    }

    class JSONAny: Codable {

        let value: Any

        static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
            return DecodingError.typeMismatch(JSONAny.self, context)
        }

        static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
            let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
            return EncodingError.invalidValue(value, context)
        }

        static func decode(from container: SingleValueDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                return value
            }
            if let value = try? container.decode(Int64.self) {
                return value
            }
            if let value = try? container.decode(Double.self) {
                return value
            }
            if let value = try? container.decode(String.self) {
                return value
            }
            if container.decodeNil() {
                return JSONNull()
            }
            throw decodingError(forCodingPath: container.codingPath)
        }

        static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                return value
            }
            if let value = try? container.decode(Int64.self) {
                return value
            }
            if let value = try? container.decode(Double.self) {
                return value
            }
            if let value = try? container.decode(String.self) {
                return value
            }
            if let value = try? container.decodeNil() {
                if value {
                    return JSONNull()
                }
            }
            if var container = try? container.nestedUnkeyedContainer() {
                return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
                return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
        }

        static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
            if let value = try? container.decode(Bool.self, forKey: key) {
                return value
            }
            if let value = try? container.decode(Int64.self, forKey: key) {
                return value
            }
            if let value = try? container.decode(Double.self, forKey: key) {
                return value
            }
            if let value = try? container.decode(String.self, forKey: key) {
                return value
            }
            if let value = try? container.decodeNil(forKey: key) {
                if value {
                    return JSONNull()
                }
            }
            if var container = try? container.nestedUnkeyedContainer(forKey: key) {
                return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
                return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
        }

        static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
            var arr: [Any] = []
            while !container.isAtEnd {
                let value = try decode(from: &container)
                arr.append(value)
            }
            return arr
        }

        static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
            var dict = [String: Any]()
            for key in container.allKeys {
                let value = try decode(from: &container, forKey: key)
                dict[key.stringValue] = value
            }
            return dict
        }

        static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
            for value in array {
                if let value = value as? Bool {
                    try container.encode(value)
                } else if let value = value as? Int64 {
                    try container.encode(value)
                } else if let value = value as? Double {
                    try container.encode(value)
                } else if let value = value as? String {
                    try container.encode(value)
                } else if value is JSONNull {
                    try container.encodeNil()
                } else if let value = value as? [Any] {
                    var container = container.nestedUnkeyedContainer()
                    try encode(to: &container, array: value)
                } else if let value = value as? [String: Any] {
                    var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                    try encode(to: &container, dictionary: value)
                } else {
                    throw encodingError(forValue: value, codingPath: container.codingPath)
                }
            }
        }

        static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
            for (key, value) in dictionary {
                let key = JSONCodingKey(stringValue: key)!
                if let value = value as? Bool {
                    try container.encode(value, forKey: key)
                } else if let value = value as? Int64 {
                    try container.encode(value, forKey: key)
                } else if let value = value as? Double {
                    try container.encode(value, forKey: key)
                } else if let value = value as? String {
                    try container.encode(value, forKey: key)
                } else if value is JSONNull {
                    try container.encodeNil(forKey: key)
                } else if let value = value as? [Any] {
                    var container = container.nestedUnkeyedContainer(forKey: key)
                    try encode(to: &container, array: value)
                } else if let value = value as? [String: Any] {
                    var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                    try encode(to: &container, dictionary: value)
                } else {
                    throw encodingError(forValue: value, codingPath: container.codingPath)
                }
            }
        }

        static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }

        public required init(from decoder: Decoder) throws {
            if var arrayContainer = try? decoder.unkeyedContainer() {
                self.value = try JSONAny.decodeArray(from: &arrayContainer)
            } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
                self.value = try JSONAny.decodeDictionary(from: &container)
            } else {
                let container = try decoder.singleValueContainer()
                self.value = try JSONAny.decode(from: container)
            }
        }

        public func encode(to encoder: Encoder) throws {
            if let arr = self.value as? [Any] {
                var container = encoder.unkeyedContainer()
                try JSONAny.encode(to: &container, array: arr)
            } else if let dict = self.value as? [String: Any] {
                var container = encoder.container(keyedBy: JSONCodingKey.self)
                try JSONAny.encode(to: &container, dictionary: dict)
            } else {
                var container = encoder.singleValueContainer()
                try JSONAny.encode(to: &container, value: self.value)
            }
        }
    }

}
