package model;

import common._enum.DataType;

import java.util.Objects;

/**
 * @file: model.Row
 * @Description: todo
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/1 15:05
 * @Company: www.xyb2b.com
 */

public class Row {
    private String rowName;

    private DataType dataType;

    private Integer length;

    private Integer decimalLength;

    private boolean isNullAble;

    private String comment;

    private String defaultValue;

    private boolean isAutoIncrease;

    private boolean timeIsUpdateWhenModify;

    private boolean isUnsigned;

    public String getRowName() {
        return rowName;
    }

    public void setRowName(String rowName) {
        this.rowName = rowName;
    }

    public DataType getDataType() {
        return dataType;
    }

    public void setDataType(DataType dataType) {
        this.dataType = dataType;
    }

    public Integer getLength() {
        return length;
    }

    public void setLength(Integer length) {
        this.length = length;
    }

    public Integer getDecimalLength() {
        return decimalLength;
    }

    public void setDecimalLength(Integer decimalLength) {
        this.decimalLength = decimalLength;
    }

    public boolean isNullAble() {
        return isNullAble;
    }

    public void setNullAble(boolean nullAble) {
        this.isNullAble = nullAble;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getDefaultValue() {
        return defaultValue;
    }

    public void setDefaultValue(String defaultValue) {
        this.defaultValue = defaultValue;
    }

    public boolean isAutoIncrease() {
        return isAutoIncrease;
    }

    public void setAutoIncrease(boolean autoIncrease) {
        isAutoIncrease = autoIncrease;
    }

    public boolean isUnsigned() {
        return isUnsigned;
    }

    public void setUnsigned(boolean unsigned) {
        this.isUnsigned = unsigned;
    }

    public boolean isTimeIsUpdateWhenModify() {
        return timeIsUpdateWhenModify;
    }

    public void setTimeIsUpdateWhenModify(boolean timeIsUpdateWhenModify) {
        this.timeIsUpdateWhenModify = timeIsUpdateWhenModify;
    }

    public boolean isPrimary(Table table){
        if (table.getPrimaryKeyRowNameList() == null || table.getPrimaryKeyRowNameList().isEmpty())
            return false;
        for (String primary : table.getPrimaryKeyRowNameList()) {
            if (primary.equalsIgnoreCase(this.rowName)) return true;
        }
        return false;
    }

    @Override
    public String toString() {
        return "Row{" +
                "rowName='" + rowName + '\'' +
                ", dataType=" + dataType +
                ", length=" + length +
                ", decimalLength=" + decimalLength +
                ", isNullAble=" + isNullAble +
                ", comment='" + comment + '\'' +
                ", defaultValue='" + defaultValue + '\'' +
                ", isAutoIncrease=" + isAutoIncrease +
                ", timeIsUpdateWhenModify=" + timeIsUpdateWhenModify +
                ", isUnsigned=" + isUnsigned +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Row row = (Row) o;

        if (isNullAble != row.isNullAble) return false;
        if (isAutoIncrease != row.isAutoIncrease) return false;
        if (isUnsigned != row.isUnsigned) return false;
        if (timeIsUpdateWhenModify != row.timeIsUpdateWhenModify) return false;
        if (!Objects.equals(rowName.trim(), row.rowName.trim())) return false;
        if (dataType != row.dataType) return false;
        if (!Objects.equals(length, row.length)) return false;
        if (!Objects.equals(decimalLength, row.decimalLength)) return false;
        if (!Objects.equals(comment.trim(), row.comment.trim())) return false;
        return Objects.equals(defaultValue, row.defaultValue);
    }



}
