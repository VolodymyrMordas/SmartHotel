package com.smarthotel.ejb.repository;

import com.smarthotel.entities.Apartment;
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
public class ApartmentRepository extends GenericRepository<Apartment, Long> {

    @PersistenceContext(unitName = "SmartHotelPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    @Override
    protected Class<Apartment> getEntityClass() {
        return Apartment.class;
    }

    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public List<Apartment> findByBuildingId(long buildingId, int page, int count){
        Query query = getEntityManager()
                .createNamedQuery("Apartment.findByApartmentId");

        query.setParameter("buildingId", buildingId);
        query.setFirstResult(page * count);
        query.setMaxResults(count);

        List<Apartment> apartmentList
                = query.getResultList();

        return apartmentList;
    }

    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public int countByBuildingId(long buildingId){
        Query query = getEntityManager()
                .createNamedQuery("Apartment.findByApartmentId");

        query.setParameter("buildingId", buildingId);

        List<Apartment> apartmentList
                = query.getResultList();

        return apartmentList.size();
    }
}