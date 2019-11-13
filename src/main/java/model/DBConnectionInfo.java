package model;

/**
 * @file: model.DBConnectionInfo
 * @Description: todo
 * @author: lingo
 * @version: v1.0
 * @date: 2019/11/7 13:47
 * @Company: www.xyb2b.com
 */

public class DBConnectionInfo {

    private String driver;

    private String url;

    private String user;

    private String password;

    public String getDriver() {
        return driver;
    }

    public void setDriver(String driver) {
        this.driver = driver;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
