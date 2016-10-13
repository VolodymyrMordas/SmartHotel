package com.smarthotel.ejb.repository;

import com.smarthotel.entities.Order;
import com.smarthotel.generic.repository.GenericRepository;

import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

@Stateless
@TransactionAttribute(TransactionAttributeType.MANDATORY)
public class OrderRepository extends GenericRepository<Order, Long> {

    @PersistenceContext(unitName = "SmartHotelPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    @Override
    protected Class<Order> getEntityClass() {
        return Order.class;
    }

    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public List<Order> findByUserId(long userId, int page, int count){
        Query query = getEntityManager()
                .createNamedQuery("Order.findByUserId");

        query.setParameter("userId", userId);
        query.setFirstResult(page * count);
        query.setMaxResults(count);

        List<Order> orderList
                = query.getResultList();

        return orderList;
    }
}