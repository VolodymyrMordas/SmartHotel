package com.smarthotel.generic.service;

import com.smarthotel.generic.entity.GenericEntity;
import com.smarthotel.generic.repository.GenericRepository;

import java.io.Serializable;

public abstract class GenericService<E extends GenericEntity<K>, K extends Serializable, R extends GenericRepository<E, K>> {

    public E find(K id){
        return getRepository().find(id);
    }

    public abstract R getRepository();
}