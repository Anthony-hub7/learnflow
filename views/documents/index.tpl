% rebase('base')
<div class="max-w-7xl mx-auto py-6">
    <div class="bg-white shadow sm:rounded-lg">
        <div class="px-4 py-5 sm:px-6 flex justify-between items-center">
            <div>
                <h2 class="text-2xl font-bold leading-7 text-gray-900 sm:tracking-tight">Documents</h2>
                <p class="mt-1 text-sm text-gray-500">Liste des documents disponibles</p>
            </div>
            % if isAdmin:
                <a href="/documents/create" 
                   class="rounded-md bg-primary px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-secondary">
                    Ajouter un document
                </a>
            % end
        </div>

        <div class="border-t border-gray-200">
            % if not documents:
                <div class="text-center py-12">
                    <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"/>
                    </svg>
                    <p class="mt-4 text-sm text-gray-500">Aucun document disponible</p>
                    % if isAdmin:
                        <div class="mt-6">
                            <a href="/documents/create" class="text-primary hover:text-secondary">Ajouter un document →</a>
                        </div>
                    % end
                </div>
            % else:
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-300">
                        <thead>
                            <tr class="bg-gray-50">
                                <th scope="col" class="py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 sm:pl-6">Titre</th>
                                <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Sujet</th>
                                <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Type</th>
                                <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Date</th>
                                % if isAdmin:
                                    <th scope="col" class="relative py-3.5 pl-3 pr-4 sm:pr-6">
                                        <span class="sr-only">Actions</span>
                                    </th>
                                % end
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200 bg-white">
                            % for doc in documents:
                                <tr class="hover:bg-gray-50">
                                    <td class="whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6">
                                        {{doc['title']}}
                                    </td>
                                    <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                                        {{doc['subject_name']}}
                                    </td>
                                    <td class="whitespace-nowrap px-3 py-4 text-sm">
                                        % type_colors = {'lesson': 'blue', 'exercise': 'green', 'exam': 'yellow', 'solution': 'purple'}
                                        % type_labels = {'lesson': 'Cours', 'exercise': 'Exercice', 'exam': 'Examen', 'solution': 'Solution'}
                                        % color = type_colors.get(doc['type'], 'gray')
                                        <span class="inline-flex items-center rounded-md px-2 py-1 text-xs font-medium ring-1 ring-inset
                                            text-{{color}}-700 bg-{{color}}-50 ring-{{color}}-600/20">
                                            {{type_labels.get(doc['type'], doc['type'])}}
                                        </span>
                                    </td>
                                    <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                                        {{doc['created_at'].strftime('%d/%m/%Y')}}
                                    </td>
                                    % if isAdmin:
                                        <td class="relative whitespace-nowrap py-4 pl-3 pr-4 text-right text-sm font-medium sm:pr-6">
                                            <div class="flex gap-2 justify-end">
                                                <a href="/documents/{{doc['id']}}" 
                                                   class="text-primary hover:text-secondary">
                                                    Voir
                                                </a>
                                                <a href="/documents/{{doc['id']}}/edit" 
                                                   class="text-primary hover:text-secondary">
                                                    Modifier
                                                </a>
                                                <button onclick="if(confirm('Êtes-vous sûr de vouloir supprimer ce document ?')) window.location.href='/documents/{{doc['id']}}/delete'"
                                                        class="text-red-600 hover:text-red-900">
                                                    Supprimer
                                                </button>
                                            </div>
                                        </td>
                                    % else:
                                        <td class="relative whitespace-nowrap py-4 pl-3 pr-4 text-right text-sm font-medium sm:pr-6">
                                            <a href="/documents/{{doc['id']}}" 
                                               class="text-primary hover:text-secondary">
                                                Voir
                                            </a>
                                        </td>
                                    % end
                                </tr>
                            % end
                        </tbody>
                    </table>
                </div>
            % end
        </div>
    </div>
</div>
