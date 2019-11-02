package _enum;

/**
 * Create by Lingo
 */

public enum DataType {
    DECIMAL("DECIMAL", 3),
    DECIMAL_UNSIGNED("DECIMAL UNSIGNED", 3),
    TINYINT("TINYINT", -6),
    TINYINT_UNSIGNED("TINYINT UNSIGNED", -6),
    BOOLEAN("BOOLEAN", 16),
    SMALLINT("SMALLINT", 5),
    SMALLINT_UNSIGNED("SMALLINT UNSIGNED", 5),
    INT("INT", 4),
    INT_UNSIGNED("INT UNSIGNED", 4),
    FLOAT("FLOAT", 7),
    FLOAT_UNSIGNED("FLOAT UNSIGNED", 7),
    DOUBLE("DOUBLE", 8),
    DOUBLE_UNSIGNED("DOUBLE UNSIGNED", 8),
    NULL("NULL", 0),
    TIMESTAMP("TIMESTAMP", 93),
    BIGINT("BIGINT", -5),
    BIGINT_UNSIGNED("BIGINT UNSIGNED", -5),
    MEDIUMINT("MEDIUMINT", 4),
    MEDIUMINT_UNSIGNED("MEDIUMINT UNSIGNED", 4),
    DATE("DATE", 91),
    TIME("TIME", 92),
    DATETIME("DATETIME", 93),
    YEAR("YEAR", 91),
    VARCHAR("VARCHAR", 12),
    VARBINARY("VARBINARY", -3),
    BIT("BIT", -7),
    JSON("JSON", -1),
    ENUM("ENUM", 1),
    SET("SET", 1),
    TINYBLOB("TINYBLOB", -3),
    TINYTEXT("TINYTEXT", 12),
    MEDIUMBLOB("MEDIUMBLOB", -4),
    MEDIUMTEXT("MEDIUMTEXT", -1),
    LONGBLOB("LONGBLOB", -4),
    LONGTEXT("LONGTEXT", -1),
    BLOB("BLOB", -4),
    TEXT("TEXT", -1),
    CHAR("CHAR", 1),
    BINARY("BINARY", -2),
    GEOMETRY("GEOMETRY", -2),
    UNKNOWN("UNKNOWN", 1111),
    ;

    private final int typeInt;
    private final String jdbcName;

    DataType(String jdbcName, int typeInt) {
        this.typeInt = typeInt;
        this.jdbcName = jdbcName;
    }

    public int getTypeInt() {
        return typeInt;
    }

    public String getJdbcName() {
        return jdbcName;
    }

    public static String getJdbcName(int typeInt) {
        for (DataType value : DataType.values()) {
            if (value.typeInt == typeInt) {
                return value.jdbcName;
            }
        }
        return "NOT FOUND";
    }

    public static DataType getInstance(String dataType) {
        for (DataType type : values()) {
            if (type.jdbcName.equalsIgnoreCase(dataType)) return type;
        }
        return null;
    }

    public static void main(String[] args) {
        System.out.println(getInstance("int"));
    }
}
