package com.smarthotel.ejb.repository;

import com.smarthotel.entities.Building;
import com.smarthotel.generic.repository.GenericRepository;

import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Stateless
@TransactionAttribute(TransactionAttributeType.MANDATORY)
public class BuildingRepository extends GenericRepository<Building, Long> {

    @PersistenceContext(unitName = "SmartHotelPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    @Override
    protected Class<Building> getEntityClass() {
        return Building.class;
    }
}