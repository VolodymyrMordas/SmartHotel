package com.smarthotel.ejb.repository;

import com.smarthotel.entities.Verification;
import com.smarthotel.generic.repository.GenericRepository;
import com.smarthotel.rest.ApplicationException;

import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

@Stateless
@TransactionAttribute(TransactionAttributeType.MANDATORY)
public class VerificationRepository extends GenericRepository<Verification, Long> {

    @PersistenceContext(unitName = "SmartHotelPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    @Override
    protected Class<Verification> getEntityClass() {
        return Verification.class;
    }

    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public Verification findByCodeType(short code, short type){
        Query query = getEntityManager()
                .createNamedQuery("Verification.findByCodeType");

        query.setParameter("code", code);
        query.setParameter("type", type);

        return (Verification) query.getSingleResult();
    }

    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public Verification findByUserType(long userId, short type) throws ApplicationException {
        Query query = getEntityManager()
                .createNamedQuery("Verification.findByUserType");

        query.setParameter("userId", userId);
        query.setParameter("type", type);

        List<Verification> verificationList = query.getResultList();

        if(verificationList.size() > 1){
            throw new ApplicationException(ApplicationException.E_4009,"too many results");
        }

        if(verificationList.size() == 0){
            return null;
        }

        return (Verification) query.getResultList().get(0);
    }

    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public Verification findByUserId(long id){
        Query query = getEntityManager()
                .createNamedQuery("Verification.findByUserId");

        query.setParameter("userId", id);

        return (Verification) query.getSingleResult();
    }
}