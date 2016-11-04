package com.smarthotel.entities;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.smarthotel.generic.entity.GenericEntity;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

@Entity
@NamedQueries({
        @NamedQuery(name = "Order.findByUserId", query = "select order from Order order where order.user.id = :userId")
})
@Table(name = "k_order", schema = "public")
public class Order extends GenericEntity<Long> implements Serializable {

    enum ORDER_STATUS {
        NEW_ORDER, PROCESS, REJECTED, COMPLETED;
    }

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    private long id;

    private String title;

    @OneToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="user_id")
    private User user;

    @OneToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="building_id")
    private Building building;

    @OneToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="apartment_id")
    private Apartment apartment;

    @Column(name = "start_at")
    @JsonProperty(value = "start_at")
    private Timestamp startAt;

    @Column(name = "end_at")
    @JsonProperty(value = "end_at")
    private Timestamp endAt;

    private short type;

    private short status;

    @Column(name = "created_at")
    @JsonProperty(value = "created_at")
    private Timestamp createdAt;

    @Column(name = "updated_at")
    @JsonProperty(value = "updated_at")
    private Timestamp updatedAt;

    @OneToMany
    @JoinColumn(name="order_id", referencedColumnName="id")
    private List<Billing> billing;

    @Id
    @Column(name = "id")
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

//    public long getUserId() {
//        return userId;
//    }

//    public void setUserId(long userId) {
//        this.userId = userId;
//    }


    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

//    public long getBuildingId() {
//        return buildingId;
//    }
//
//    public void setBuildingId(long buildingId) {
//        this.buildingId = buildingId;
//    }
//
//    public long getApartmentId() {
//        return apartmentId;
//    }
//
//    public void setApartmentId(long apartmentId) {
//        this.apartmentId = apartmentId;
//    }
//


    public List<Billing> getBilling() {
        return billing;
    }

    public void setBilling(List<Billing> billingList) {
        this.billing = billingList;
    }

    public Building getBuilding() {
        return building;
    }

    public void setBuilding(Building building) {
        this.building = building;
    }

    public Apartment getApartment() {
        return apartment;
    }

    public void setApartment(Apartment apartment) {
        this.apartment = apartment;
    }

    public Timestamp getStartAt() {
        return startAt;
    }

    public void setStartAt(Timestamp startAt) {
        this.startAt = startAt;
    }

    public Timestamp getEndAt() {
        return endAt;
    }

    public void setEndAt(Timestamp endAt) {
        this.endAt = endAt;
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

        Order order = (Order) o;

        if (id != order.id) return false;
        if (type != order.type) return false;
        if (status != order.status) return false;
        if (title != null ? !title.equals(order.title) : order.title != null) return false;
        if (startAt != null ? !startAt.equals(order.startAt) : order.startAt != null) return false;
        if (endAt != null ? !endAt.equals(order.endAt) : order.endAt != null) return false;
        if (createdAt != null ? !createdAt.equals(order.createdAt) : order.createdAt != null) return false;
        if (updatedAt != null ? !updatedAt.equals(order.updatedAt) : order.updatedAt != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (title != null ? title.hashCode() : 0);
        result = 31 * result + (startAt != null ? startAt.hashCode() : 0);
        result = 31 * result + (endAt != null ? endAt.hashCode() : 0);
        result = 31 * result + (int) type;
        result = 31 * result + (int) status;
        result = 31 * result + (createdAt != null ? createdAt.hashCode() : 0);
        result = 31 * result + (updatedAt != null ? updatedAt.hashCode() : 0);
        return result;
    }
}
