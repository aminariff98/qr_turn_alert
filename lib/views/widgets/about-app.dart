import 'package:flutter/material.dart';
import 'package:qr_turn_alert/main.dart';
import 'package:qr_turn_alert/views/widgets/app-nav-bar.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppNavBarFlat(
          title: 'About App',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(userScreenPadding),
              child: Text(
                '“TNC-service package” by the Finnish NSU: The service package was developed to support goal-oriented transnational networking. This applies when a potential TNC partner is identified’, the first round of discussions completed through emails, Skype etc. and the partners are ready to sign a cooperation agreement. The NSU can then contribute towards the costs of the travel of the Finnish counterpart to be able to attend the relevant meeting with partners. The TNC-service package can also be used to cover travel costs when attending EU-level working groups etc. NRN support to preparatory actions in Spain: Preparatory visits here can be financed by the preparatory support in most cases, once the cooperation project is officially proposed. Prior to such official submission of a proposal, the NRN can support field visits for LAGs that have common interests and are planning to develop a cooperation project. The ‘All-Island LEADER Cooperation Scheme’ between UK-Northern Ireland and Ireland: Within the NIRDP, there is a specific strand focusing on Cooperation between LAGs in Northern Ireland and those in Ireland. This is known as the All-Island LEADER Cooperation Scheme. Each NI LAG is expected to participate in a minimum of two full Cooperation projects delivered under this Scheme. These projects may also involve LAGs from other Member States but as a minimum must involve at least one LAG from NI and one LAG from Ireland. (Source: Guidance for the implementation of LEADER Cooperation activities in the Rural Development Programme for Northern Ireland 2014-2020) The “LEAD MA/PA” concept applied in Germany: This concept aims to facilitate a more coordinated process for cooperation project approval. In case of cooperation projects submitted for support which involve a ‘lead’ or coordinating LAG partner, the administrative rules relevant for the lead-partner will apply. Two out of 13 RDPs in Germany include a provision that the Managing Authorities and Paying Agencies accept the administrative rules relevant for the lead-partner. In practice, this may mean that the cooperating LAGs in the two RDP territories have – for instance - different maximum thresholds for certain types of expenditure (e.g. printing of brochures), but the threshold applicable to the lead-LAG will be accepted by the Paying Agency. Recognising the “gradual nature of cooperation” and the importance of preparatory support in Northern Ireland: Cooperation actions can be developed in three successive phases including networking, preparatory technical support (pre-development phase), and the implementation of the cooperation project. Receiving preparatory technical support does not imply an obligation to later carry out a cooperation project, but it is important that the LAG can demonstrate that it is envisaging the implementation of a concrete project. There should be no restriction on the number of preparatory actions that a LAG may implement, within a certain budget threshold. In NIE, a Preparatory technical support – Information template is used for applying for preparatory technical support. The Cooperation Agreement is an obligatory part of the application for support for cooperation projects. (Source: Guidance for the implementation of LEADER Cooperation activities in the Rural Development Programme for Northern Ireland 2014-2020)',
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyText2!.apply(fontSizeDelta: userTextSize),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
