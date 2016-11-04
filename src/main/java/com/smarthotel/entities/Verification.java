package com.smarthotel.entities;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.smarthotel.generic.entity.GenericEntity;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

@Entity
@NamedQueries({
        @NamedQuery(name = "Verification.findByCodeType", query = "select v from Verification v where v.code = :code and v.type = :type"),
        @NamedQuery(name = "Verification.findByUserType", query = "select v from Verification v where v.userId = :userId and v.type = :type"),
        @NamedQuery(name = "Verification.findByUserId", query = "select v from Verification v where v.userId = :userId")
})
@Table(name = "k_verification", schema = "public")
public class Verification extends GenericEntity<Long> implements Serializable {

    public static short T_PHONE = 0;
    public static short T_EMAIL = 1;

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    private Long id;

    private short code;

    @Column(name = "user_id")
    @JsonProperty(value = "user_id")
    private long userId;

    @Column(name = "type")
    private short type;

    @Column(name = "created_at")
    @JsonProperty(value = "created_at")
    private Timestamp createdAt;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public short getCode() {
        return code;
    }

    public void setCode(short code) {
        this.code = code;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public short getType() {
        return type;
    }

    public void setType(short type) {
        this.type = type;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Verification that = (Verification) o;

        if (id != that.id) return false;
        if (code != that.code) return false;
        if (userId != that.userId) return false;
        if (createdAt != null ? !createdAt.equals(that.createdAt) : that.createdAt != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (int) code;
        result = 31 * result + (int) (userId ^ (userId >>> 32));
        result = 31 * result + (createdAt != null ? createdAt.hashCode() : 0);
        return result;
    }

    @PrePersist
    public void prePersist(){
        this.createdAt = new Timestamp((new Date()).getTime());
    }

    public static Short createdCode(){
        return (short)(Math.random() * 10000);
    }
}
