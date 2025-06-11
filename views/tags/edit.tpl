% rebase('base')
<div class="max-w-2xl mx-auto p-6">
    <h2 class="text-2xl font-bold text-gray-800 mb-6">
        <i class="fas fa-tag text-primary mr-2"></i>
        {{ 'Créer un tag' if not tag else 'Modifier le tag' }}
    </h2>
    
    <form action="{{'/tags/' + str(tag['id']) + '/edit'}}" method="post" class="space-y-6">
        <div class="space-y-2">
            <label class="block text-sm font-medium text-gray-700">
                Nom
                <input type="text" 
                       name="name" 
                       value="{{tag['name'] if tag else ''}}" 
                       required
                       placeholder="Entrez le nom du tag"
                       class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-primary focus:ring-primary sm:text-sm
                       border p-2 focus:outline-none">
            </label>
            <p class="text-sm text-gray-500 mt-1">
                Le nom du tag servira à catégoriser et retrouver facilement vos documents
            </p>
        </div>

        <div class="flex gap-4">
            <button type="submit"
                class="bg-primary text-white px-4 py-2 rounded-lg hover:bg-secondary transition duration-300">
                <i class="fas fa-save mr-2"></i>
                {{ 'Créer' if not tag else 'Mettre à jour' }}
            </button>
            <a href="/tags"
                class="bg-gray-100 text-gray-700 px-4 py-2 rounded-lg hover:bg-gray-200 transition duration-300">
                <i class="fas fa-times mr-2"></i>
                Annuler
            </a>
        </div>
    </form>
</div>
