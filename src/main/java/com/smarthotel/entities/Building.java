package com.smarthotel.entities;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.smarthotel.generic.entity.GenericEntity;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;

@Entity
@Table(name = "k_building", schema = "public", catalog = "karolino")
public class Building extends GenericEntity<Long> implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    private Long id;

    private String title;

    private String description;

    private BigDecimal lat;

    private BigDecimal lng;

    private short type;

    private short status;

    @Column(name = "created_at")
    @JsonProperty(value = "created_at")
    private Timestamp createdAt;

    @Column(name = "updated_at")
    @JsonProperty(value = "updated_at")
    private Timestamp updatedAt;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getLat() {
        return lat;
    }

    public void setLat(BigDecimal lat) {
        this.lat = lat;
    }

    public BigDecimal getLng() {
        return lng;
    }

    public void setLng(BigDecimal lng) {
        this.lng = lng;
    }

    public short getType() {
        return type;
    }

    public void setType(short type) {
        this.type = type;
    }

    public short getStatus() {
        return status;
    }

    public void setStatus(short status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Building building = (Building) o;

        if (id != building.id) return false;
        if (type != building.type) return false;
        if (status != building.status) return false;
        if (title != null ? !title.equals(building.title) : building.title != null) return false;
        if (lat != null ? !lat.equals(building.lat) : building.lat != null) return false;
        if (lng != null ? !lng.equals(building.lng) : building.lng != null) return false;
        if (createdAt != null ? !createdAt.equals(building.createdAt) : building.createdAt != null) return false;
        if (updatedAt != null ? !updatedAt.equals(building.updatedAt) : building.updatedAt != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (title != null ? title.hashCode() : 0);
        result = 31 * result + (lat != null ? lat.hashCode() : 0);
        result = 31 * result + (lng != null ? lng.hashCode() : 0);
        result = 31 * result + (int) type;
        result = 31 * result + (int) status;
        result = 31 * result + (createdAt != null ? createdAt.hashCode() : 0);
        result = 31 * result + (updatedAt != null ? updatedAt.hashCode() : 0);
        return result;
    }

    @PreUpdate
    public void preUpdate(){
        this.setUpdatedAt(new Timestamp((new Date()).getTime()));
    }

    @PrePersist
    public void prePersist(){
        this.setCreatedAt(new Timestamp((new Date()).getTime()));
        this.setUpdatedAt(new Timestamp((new Date()).getTime()));
    }
}
