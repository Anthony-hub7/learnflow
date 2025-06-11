% rebase('base')
<div class="max-w-2xl mx-auto p-6">
    <h2 class="text-2xl font-bold text-gray-800 mb-6">
        {{ 'Créer un document' if not document else 'Modifier le document' }}
    </h2>
    
    <form action="{{'/documents/create' if not document else '/documents/' + str(document['id']) + '/edit'}}" 
          method="post" 
          enctype="multipart/form-data" 
          class="space-y-6">
        
        <div class="space-y-2">
            <label class="block text-sm font-medium text-gray-700">
                Titre
                <input type="text" 
                       name="title" 
                       value="{{document['title'] if document else ''}}" 
                       required
                       class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-primary focus:ring-primary sm:text-sm border p-2 focus:outline-none">
            </label>
        </div>

        <div class="space-y-2">
            <label class="block text-sm font-medium text-gray-700">
                Matière
                <select name="subject_id" 
                        required
                        class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-primary focus:ring-primary sm:text-sm border p-2 focus:outline-none">
                    <option value="">-- Choisir une matière --</option>
                    % for subj in subjects:
                        <option value="{{subj['id']}}" 
                            {{ 'selected' if document and document['subject_id'] == subj['id'] else '' }}>
                            {{subj['name']}}
                        </option>
                    % end
                </select>
            </label>
        </div>

        <div class="space-y-2">
            <label class="block text-sm font-medium text-gray-700">
                Type
                <select name="type" 
                        required
                        class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-primary focus:ring-primary sm:text-sm border p-2 focus:outline-none">
                    % for t in ['lesson', 'exercise', 'exam', 'solution']:
                        <option value="{{t}}" 
                            {{ 'selected' if document and document['type'] == t else '' }}>
                            {{ {'lesson': 'Cours', 'exercise': 'Exercice', 'exam': 'Examen', 'solution': 'Solution'}[t] }}
                        </option>
                    % end
                </select>
            </label>
        </div>

        <div class="space-y-2">
            <label class="block text-sm font-medium text-gray-700">
                Description
                <textarea name="description" 
                          rows="4"
                          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-primary focus:ring-primary sm:text-sm border p-2 focus:outline-none">{{document['description'] if document else ''}}</textarea>
            </label>
        </div>

        <div class="space-y-2">
            <label class="block text-sm font-medium text-gray-700">
                Fichier
                % if document and document['file_name']:
                    <div class="mt-1 mb-2 text-sm text-gray-500">
                        Fichier actuel : {{document['file_name']}}
                    </div>
                % end
                <input type="file" 
                       name="file"
                       {{ 'required' if not document else '' }}
                       class="mt-1 block w-full text-sm text-gray-500
                              file:mr-4 file:py-2 file:px-4
                              file:rounded-md file:border-0
                              file:text-sm file:font-semibold
                              file:bg-primary file:text-white
                              hover:file:bg-secondary">
            </label>
        </div>

        <div class="flex gap-4">
            <button type="submit"
                    class="bg-primary text-white px-4 py-2 rounded-lg hover:bg-secondary transition duration-300">
                {{ 'Créer' if not document else 'Enregistrer' }}
            </button>
            <a href="/documents"
               class="bg-gray-100 text-gray-700 px-4 py-2 rounded-lg hover:bg-gray-200 transition duration-300">
                Annuler
            </a>
        </div>
    </form>
</div>
