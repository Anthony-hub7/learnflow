% rebase('base')
<div class="max-w-2xl mx-auto p-6">
    <h2 class="text-2xl font-bold text-gray-800 mb-6">Modifier la matière</h2>
    
    <form action="/subjects/{{subjects['id']}}/edit" method="post" class="space-y-6">
        <div class="space-y-2">
            <label class="block text-sm font-medium text-gray-700">
                Nom
                <input type="text" name="name" value="{{subjects['name']}}" required
                    class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-primary focus:ring-primary sm:text-sm
                    border p-2 focus:outline-none">
            </label>
        </div>

        <div class="space-y-2">
            <label class="block text-sm font-medium text-gray-700">
                Description
                <textarea name="description" rows="4"
                    class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-primary focus:ring-primary sm:text-sm
                    border p-2 focus:outline-none">{{subjects['description']}}</textarea>
            </label>
        </div>

        <div class="space-y-2">
            <label class="block text-sm font-medium text-gray-700">
                Catégorie
                <select name="category_id" required
                    class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-primary focus:ring-primary sm:text-sm
                    border p-2 focus:outline-none">
                    % for category in categories:
                        <option value="{{category['id']}}" {{'selected' if subjects.get('category_id') == category['id'] else ''}}>
                            {{category['name']}}
                        </option>
                    % end
                </select>
            </label>
        </div>

        <div class="flex gap-4">
            <button type="submit"
                class="bg-primary text-white px-4 py-2 rounded-lg hover:bg-secondary transition duration-300">
                Enregistrer
            </button>
            <a href="/subjects"
                class="bg-gray-100 text-gray-700 px-4 py-2 rounded-lg hover:bg-gray-200 transition duration-300">
                Retour
            </a>
        </div>
    </form>
</div>
