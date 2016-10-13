package com.smarthotel.entities;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.smarthotel.generic.entity.GenericEntity;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@Entity
@NamedQueries({
        @NamedQuery(name = "Apartment.findByApartmentId", query = "select a from Apartment a where a.buildingId = :buildingId")
})
@Table(name = "k_apartment", schema = "public", catalog = "karolino")
public class Apartment extends GenericEntity<Long> implements Serializable {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    private Long id;

    @Column(name = "building_id")
    @JsonProperty(value = "building_id")
    private Long buildingId;

    private String title;
    private String description;
    private String number;

    private short type;

    private short status;

    @Column(name = "created_at")
    @JsonProperty(value = "created_at")
    private Timestamp createdAt;

    @Column(name = "updated_at")
    @JsonProperty(value = "updated_at")
    private Timestamp updatedAt;

    @OneToMany
    @JoinColumn(name="apartment_id", referencedColumnName="id")
    private List<ApartmentMedia> media;


    @OneToMany
    @JoinColumn(name="apartment_id", referencedColumnName="id")
    private List<ApartmentPrice> price;

    @Transient
    private ApartmentPrice currentPrice;

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

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<ApartmentMedia> getMedia() {
        return media;
    }

    public void setMedia(List<ApartmentMedia> media) {
        this.media = media;
    }

    public List<ApartmentPrice> getPrice() {
        return price;
    }

    public void setPrice(List<ApartmentPrice> price) {
        this.price = price;
    }

    @JsonProperty(value = "current_price")
    public ApartmentPrice getCurrentPrice() {
        Timestamp currentTimestamp = new Timestamp((new Date()).getTime());
        for (ApartmentPrice price : this.getPrice()){
            if(price.getStartAt().before(currentTimestamp)){
                currentPrice = price;
            }
        }
        return currentPrice;
    }

    public Long getBuildingId() {
        return buildingId;
    }

    public void setBuildingId(Long buildingId) {
        this.buildingId = buildingId;
    }

    public void setCurrentPrice(ApartmentPrice currentPrice) {
        this.currentPrice = currentPrice;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Apartment apartment = (Apartment) o;

        if (id != apartment.id) return false;
        if (type != apartment.type) return false;
        if (status != apartment.status) return false;
        if (title != null ? !title.equals(apartment.title) : apartment.title != null) return false;
        if (createdAt != null ? !createdAt.equals(apartment.createdAt) : apartment.createdAt != null) return false;
        if (updatedAt != null ? !updatedAt.equals(apartment.updatedAt) : apartment.updatedAt != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (title != null ? title.hashCode() : 0);
        result = 31 * result + (int) type;
        result = 31 * result + (int) status;
        result = 31 * result + (createdAt != null ? createdAt.hashCode() : 0);
        result = 31 * result + (updatedAt != null ? updatedAt.hashCode() : 0);
        return result;
    }

    @PrePersist
    public void prePersist(){
        this.createdAt = new Timestamp((new Date()).getTime());
        this.updatedAt = new Timestamp((new Date()).getTime());
    }

    @PreUpdate
    public void preUpdate(){
        this.updatedAt = new Timestamp((new Date()).getTime());
    }
}
