package ma.ac.esi.gameverseacademy.service;

import ma.ac.esi.gameverseacademy.model.Mod;
import ma.ac.esi.gameverseacademy.repository.ModRepository;

import java.util.List;

public class ModService {

    private ModRepository modRepository = new ModRepository();

    public List<Mod> getAllMods() {
        return modRepository.getAllMods();
    }

    public Mod getModById(int id) {
        return modRepository.getModById(id);
    }

    public List<Mod> getModsByCategory(String category) {
        List<Mod> all      = modRepository.getAllMods();
        List<Mod> filtered = new java.util.ArrayList<>();
        for (Mod mod : all) {
            if (mod.getCategory() != null &&
                mod.getCategory().equalsIgnoreCase(category)) {
                filtered.add(mod);
            }
        }
        return filtered;
    }
     
    public boolean submitMod(Mod mod) {
        if (mod.getTitle() == null || mod.getTitle().trim().isEmpty()) {
            return false;
        }
        return modRepository.insertMod(mod);
    }
    public boolean deleteMod(int id) {
        if (id <= 0) return false;
        return modRepository.deleteMod(id);
    }
    
    public boolean updateMod(Mod mod) {
        if (mod.getTitle() == null || mod.getTitle().trim().isEmpty()) {
            return false;
        }
        return modRepository.updateMod(mod);
    }

}