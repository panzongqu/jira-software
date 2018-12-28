FROM cptactionhank/atlassian-jira-software
ENV JIRA_HOME /var/atlassian/jira
ENV JIRA_INSTALL /opt/atlassian/jira

RUN set -x \
    && chmod -R 700        "${JIRA_HOME}" \
    && chown daemon:daemon "${JIRA_HOME}" \
    && chmod -R 700            "${JIRA_INSTALL}/conf" \
    && chmod -R 700            "${JIRA_INSTALL}/logs" \
    && chmod -R 700            "${JIRA_INSTALL}/temp" \
    && chmod -R 700            "${JIRA_INSTALL}/work" \
    && chown -R daemon:daemon  "${JIRA_INSTALL}/conf" \
    && chown -R daemon:daemon  "${JIRA_INSTALL}/logs" \
    && chown -R daemon:daemon  "${JIRA_INSTALL}/temp" \
    && chown -R daemon:daemon  "${JIRA_INSTALL}/work"

USER daemon:daemon
EXPOSE 8080
VOLUME ["/var/atlassian/jira", "/opt/atlassian/jira/logs"]
WORKDIR /var/atlassian/jira
COPY "atlassian-extras-3.2.jar" "${JIRA_INSTALL}/atlassian-jira/WEB-INF/lib"
COPY --chown=daemon:daemon "workdir_data.tar.gz" "${JIRA_INSTALL}/temp"
COPY --chown=daemon:daemon "docker-entrypoint.sh" "/"

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/opt/atlassian/jira/bin/start-jira.sh", "-fg"]
