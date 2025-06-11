% rebase('base')
<div class="max-w-7xl mx-auto py-6">
    <div class="bg-white shadow sm:rounded-lg">
        <div class="px-4 py-5 sm:px-6">
            <div class="flex items-center justify-between">
                <div>
                    <h2 class="text-2xl font-bold leading-7 text-gray-900 sm:tracking-tight">{{document['title']}}</h2>
                    <p class="mt-1 max-w-2xl text-sm text-gray-500">
                        Créé le {{document['created_at'].strftime('%d/%m/%Y à %H:%M')}}
                    </p>
                </div>
                <div class="flex gap-3">
                    <a href="/documents/{{document['id']}}/edit" 
                       class="rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50">
                        Modifier
                    </a>
                    <button onclick="if(confirm('Êtes-vous sûr de vouloir supprimer ce document ?')) window.location.href='/documents/{{document['id']}}/delete'"
                            class="rounded-md bg-red-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-red-500">
                        Supprimer
                    </button>
                </div>
            </div>
        </div>

        <div class="border-t border-gray-200 px-4 py-5 sm:px-6">
            <dl class="grid grid-cols-1 gap-x-4 gap-y-6 sm:grid-cols-2">
                <div>
                    <dt class="text-sm font-medium text-gray-500">Sujet</dt>
                    <dd class="mt-1 text-sm text-gray-900">{{document['subject_name']}}</dd>
                </div>

                <div>
                    <dt class="text-sm font-medium text-gray-500">Type</dt>
                    <dd class="mt-1">
                        % type_colors = {'lesson': 'blue', 'exercise': 'green', 'exam': 'yellow', 'solution': 'purple'}
                        % type_labels = {'lesson': 'Cours', 'exercise': 'Exercice', 'exam': 'Examen', 'solution': 'Solution'}
                        <span class="inline-flex items-center rounded-md px-2 py-1 text-xs font-medium ring-1 ring-inset
                            % color = type_colors.get(document['type'], 'gray')
                            text-{{color}}-700 bg-{{color}}-50 ring-{{color}}-600/20">
                            {{type_labels.get(document['type'], document['type'])}}
                        </span>
                    </dd>
                </div>

                <div class="sm:col-span-2">
                    <dt class="text-sm font-medium text-gray-500">Tags</dt>
                    <dd class="mt-1">
                        <div class="space-y-3">
                            % if document.get('tags'):
                                <div class="flex flex-wrap gap-2">
                                    % for tag in document['tags']:
                                        <span class="inline-flex items-center rounded-md bg-blue-50 px-2 py-1 text-xs font-medium text-blue-700 ring-1 ring-inset ring-blue-700/10">
                                            {{tag['name']}}
                                        </span>
                                    % end
                                </div>
                            % end
                            
                            <a href="/documents/{{document['id']}}/tags" 
                               class="inline-flex items-center rounded-md bg-primary px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-secondary gap-2">
                                <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A2 2 0 013 12V7a4 4 0 014-4z"/>
                                </svg>
                                Gérer les tags
                            </a>
                        </div>
                    </dd>
                </div>

                % if document.get('description'):
                    <div class="sm:col-span-2">
                        <dt class="text-sm font-medium text-gray-500">Description</dt>
                        <dd class="mt-1 text-sm text-gray-900 whitespace-pre-wrap">{{document['description']}}</dd>
                    </div>
                % end

                <div class="sm:col-span-2">
                    <dt class="text-sm font-medium text-gray-500">Fichier</dt>
                    <dd class="mt-1">
                        <div class="flex items-center gap-4">
                            <span class="text-sm text-gray-900">{{document['file_name']}}</span>
                            <a href="/documents/{{document['id']}}/download"
                               class="rounded-md bg-primary px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-secondary">
                                Télécharger
                            </a>
                        </div>
                    </dd>
                </div>
            </dl>
        </div>

        % if document.get('content_preview'):
            <div class="border-t border-gray-200 px-4 py-5 sm:px-6">
                <h3 class="text-lg font-medium text-gray-900 mb-4">Aperçu du contenu</h3>
                <div class="bg-gray-50 rounded-lg p-4 overflow-x-auto">
                    <pre class="text-sm text-gray-700">{{document['content_preview']}}</pre>
                </div>
            </div>
        % end
    </div>

    <div class="mt-6">
        <a href="/documents" class="text-primary hover:text-secondary">← Retour à la liste</a>
    </div>
</div>
