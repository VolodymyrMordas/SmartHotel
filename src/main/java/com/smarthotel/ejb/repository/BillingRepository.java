package com.smarthotel.ejb.repository;

import com.smarthotel.entities.Billing;
import com.smarthotel.generic.repository.GenericRepository;

import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Stateless
@TransactionAttribute(TransactionAttributeType.MANDATORY)
public class BillingRepository extends GenericRepository<Billing, Long> {

    @PersistenceContext(unitName = "SmartHotelPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    @Override
    protected Class<Billing> getEntityClass() {
        return Billing.class;
    }
}